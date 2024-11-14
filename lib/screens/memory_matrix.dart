import 'dart:math';
import 'package:flutter/material.dart';
import '../components/simple_app_bar.dart';
import '../models/ImgGrid.dart';

class MemoryMatrix extends StatefulWidget {
  const MemoryMatrix({super.key, required this.appBarTitle});
  final String appBarTitle;

  @override
  State<MemoryMatrix> createState() => _MemoryMatrixState();
}

class _MemoryMatrixState extends State<MemoryMatrix> {
  int crossAxisCount = 4;
  int gridCount = 16;
  int currentLevel = 4;
  int correctClicks = 0;
  List<ImgGrid> imgGridList = [];

  @override
  void initState() {
    generateGridList(false);
    super.initState();
  }

  generateGridList(bool regenerating){

    if(regenerating){
      imgGridList = [];

      currentLevel += correctClicks;
      if(correctClicks/3 ==0){
        setState(() {
          gridCount++;
        });
      }
    }

    List<int> rawImgList = [];
    for(int i=0; i<gridCount; i++){
      imgGridList.add( ImgGrid('', i, false) );
      rawImgList.add(i);
    }

    for(int i=0; i<currentLevel; i++){
      int randPos = Random().nextInt(rawImgList.length);
      imgGridList[ rawImgList[randPos] ].show=true;
      rawImgList.removeAt(randPos);
    }

    if(regenerating){
      setState(() {

      });
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
    /*if(isGameCompleted()){
      return gameCompleted( widget.appBarTitle );
    } else {*/
      return runningGame(context);
    //}
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
    double gridItemSize = availableWidth < availableHeight ? availableWidth : availableHeight;

    return Center(
      child: SizedBox(
        width: gridItemSize,
        height: gridItemSize,
        child: GridView.builder(
          padding: const EdgeInsets.all(0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: gridCount,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                correctClicks++;
                generateGridList(true);
              },
                child: getGrid(index)
            );
          },
        ),
      ),
    );

  }//runningGame

  Widget getGrid(int index) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: Center(
        child: Image.asset(
          imgGridList[index].show ? 'assets/images/numbers/9.png' : 'assets/images/ubuntu_plain.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

}