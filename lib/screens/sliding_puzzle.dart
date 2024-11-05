import 'dart:math';
import 'package:flutter/material.dart';
import '../components/game_commons.dart';
import '../models/ImgGrid.dart';
import '../components/simple_app_bar.dart';

class SlidingPuzzle extends StatefulWidget {
  const SlidingPuzzle({super.key, required this.appBarTitle});
  final String appBarTitle;

  @override
  State<SlidingPuzzle> createState() => _SlidingPuzzleState();
}

class _SlidingPuzzleState extends State<SlidingPuzzle> {
  List<String> rawImgList = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  int crossAxisCount = 3;
  int gridSize = 9;
  List<ImgGrid> imgGridList = [];
  int emptyPosition = 0;

  @override
  void initState() {
    generateGridList();
    super.initState();
  }

  generateGridList(){
    for(int i=0; i<gridSize; i++){
      int randPos = Random().nextInt(rawImgList.length);
      imgGridList.add( ImgGrid(rawImgList[randPos], i, true) );

      if(rawImgList[randPos].compareTo('9')==0){
        emptyPosition = i;
      }

      rawImgList.removeAt(randPos);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(widget.appBarTitle, context),
      body: getGameScreen(context),
    );
  }

  Widget getGameScreen(BuildContext context){
    if(isGameCompleted()){
      return gameCompleted( widget.appBarTitle );
    } else {
      return runningGame(context);
    }
  }

  bool isGameCompleted(){
    for(int i=0; i<gridSize; i++){
      if(imgGridList[i].imgPath.compareTo( (imgGridList[i].posInGrid+1).toString() )!=0){
        print('isGameCompleted imgPath=${imgGridList[i].imgPath}');
        print('isGameCompleted posInGrid=${imgGridList[i].posInGrid}');
        return false;
      }
    }

    return true;
  }

  Widget runningGame(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double gridPadding = 10; // total padding (left + right + top + bottom)
    double totalSpacing = (crossAxisCount - 1) * 10; // total spacing between items

    // Calculate the available size for the grid
    double availableWidth = screenWidth - gridPadding;
    double availableHeight = screenHeight - gridPadding - 60;

    // Determine the size of the grid
    double gridSize = availableWidth < availableHeight ? availableWidth : availableHeight;

    return Center(
      child: SizedBox(
        width: gridSize,
        height: gridSize,
        child: GridView.builder(
          padding: const EdgeInsets.all(0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 9, // Since you want 9 images
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {

                bool isNear = isSpecificNeighbor(index, emptyPosition);
                if(isNear) {
                  setState(() {
                    var swap = imgGridList[emptyPosition];
                    imgGridList[emptyPosition] = imgGridList[index];
                    imgGridList[index] = swap;

                    imgGridList[emptyPosition].posInGrid = emptyPosition;
                    imgGridList[index].posInGrid = index;

                    emptyPosition = index;
                  });
                }

              },
              child: getGrid(imgGridList[index]),
            );
          },
        ),
      ),
    );

  }//runningGame

  Map<int, List<int>> neighborMap = {
    0: [1, 3],       // Neighbors of position 0
    1: [0, 2, 4],    // Neighbors of position 1
    2: [1, 5],       // Neighbors of position 2
    3: [0, 4, 6],    // Neighbors of position 3
    4: [1, 3, 5, 7], // Neighbors of position 4
    5: [2, 4, 8],    // Neighbors of position 5
    6: [3, 7],       // Neighbors of position 6
    7: [4, 6, 8],    // Neighbors of position 7
    8: [5, 7],       // Neighbors of position 8
  };

  bool isSpecificNeighbor(int pos1, int pos2) {
    return neighborMap[pos1]?.contains(pos2) ?? false;
  }

  Widget getGrid(ImgGrid imgGrid) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: Center(
        child: Image.asset(
          imgGrid.show ? 'assets/images/numbers/${imgGrid.imgPath}.png' : 'assets/images/ubuntu_plain.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

}
