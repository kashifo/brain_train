import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/common_views.dart';

class FindThePair extends StatefulWidget {
  const FindThePair({super.key, required this.appBarTitle});
  final String appBarTitle;

  @override
  State<FindThePair> createState() => _FindThePairState();
}

class ImgGrid{
  String imgPath;
  int posInGrid;
  bool show;

  ImgGrid(String this.imgPath, int this.posInGrid, bool this.show);
}

class _FindThePairState extends State<FindThePair> {
  List<String> rawImgList = ['mark_face.png', 'elon_musk.jpg', 'steve.jpg', 'linus.jpg', 'ola_s1x.jpg', 'gilfoyle.jpg', 'erlich.jpg', 'kas_inf.jpg', 'richard.jpg', 'mark.jpg', 'mark_pc.jpg', 'kas_fizz_300.jpg'];
  int gridSize = 24;
  List<ImgGrid> imgGridList = [];
  List<ImgGrid> clickList = [];

  @override
  void initState() {
    generateGridList();
    super.initState();
  }

  generateGridList(){
    List<String> imgPairList = [];
    imgPairList.addAll(rawImgList);
    imgPairList.addAll(rawImgList);

    for(int i=0; i<gridSize; i++){
      int randPos = Random().nextInt(imgPairList.length);
      imgGridList.add( ImgGrid(imgPairList[randPos], i, false) );
      imgPairList.removeAt(randPos);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(widget.appBarTitle),
      body: getGameScreen(context),
    );
  }

  Widget getGameScreen(BuildContext context){
    // if(gridPositionList.isNotEmpty){
      return runningGame(context);
    /*} else {
      return gameCompleted();
    }*/
  }

  int getCrossAxisCount(double screenWidth){
    if(screenWidth>=1036){
      return 8;
    } else if(screenWidth>536){
      return 6;
    } else {
      return 4;
    }
  }

  Widget runningGame(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = getCrossAxisCount(screenWidth);

    double gridPadding = 20; // 10 padding on each side
    double totalMainAxisSpacing = (crossAxisCount - 1) * 10; // Spacing between rows
    double availableHeight = screenHeight - gridPadding - totalMainAxisSpacing - 180;
    double mainAxisExtent = availableHeight / (gridSize / crossAxisCount);

    var gridWidth = (screenWidth / crossAxisCount) - 10;
    print('mainAxisExtent=$mainAxisExtent, gridWidth=$gridWidth');
    print('screenWidth=$screenWidth, screenHeight=$screenHeight');
    //flutter: screenWidth=538.0, screenHeight=725.0
    //flutter: screenWidth=1031.0, screenHeight=725.0
    //994, 536, 442,
    //todo: handle the case of gridHeight*crossAxisCount > scrHeight

    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: (1 / .4),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: gridWidth, // Use the calculated height
            ),
            itemCount: gridSize,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                    if (clickList.isEmpty) {

                      setState(() {
                        clickList.add(imgGridList[index]);
                        imgGridList[index].show = true;
                      });

                    } else {

                      if (clickList[0].imgPath.compareTo(imgGridList[index].imgPath) == 0) {

                        setState(() {
                          imgGridList[index].show = true;
                          clickList.clear();
                        });

                      } else {
                        incorrectClick(index);
                      }

                    }
                },
                child: getGrid(imgGridList[index]),
              );
            },
          ),
        )
      ],
    );
  }

  incorrectClick(int index) async {
    setState(() {
      imgGridList[index].show = true;
    });

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      imgGridList[index].show = false;
      imgGridList[clickList[0].posInGrid].show = false;
      clickList.clear();
    });
  }

  Widget gameCompleted(){
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/icons/brain_train_logo_wbg_512px.jpg', width: 100, height: 100,),
          Text('Brain Train', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),),
          Text('Find the Number', style: TextStyle(fontSize: 16),),
          SizedBox(height: 8),
          Text('Congratulations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          Text('You\'ve completed the game', style: TextStyle(fontSize: 18),),
        ],
      ),
    );
  }

  Widget getGrid(ImgGrid imgGrid) {

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: Center(
        child: Image.asset(
          imgGrid.show ? 'assets/images/classic_puzzle/${imgGrid.imgPath}' : 'assets/images/ubuntu_plain.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

}
