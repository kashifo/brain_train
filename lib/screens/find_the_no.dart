import 'dart:math';
import 'package:flutter/material.dart';

import '../utils/common_views.dart';
import '../utils/ResponsiveUtils.dart';

class FindTheNo extends StatefulWidget {
  const FindTheNo({super.key, required this.appBarTitle});
  final String appBarTitle;

  @override
  State<FindTheNo> createState() => _FindTheNoState();
}

class GridNum {
  Color? color;
  int? number;
  bool hide;

  GridNum(Color this.color, int this.number, this.hide);

  String getNumberToShow(){
    if(hide || number==null){
      return '';
    } else {
      return number.toString();
    }
  }

  @override
  String toString() {
    return 'GridNum{color: ${color?.value.toString()}, number: $number}';
  }
}

class _FindTheNoState extends State<FindTheNo> {
  List<GridNum> gridList = [];
  List<int> gridPositionList = [];
  int curGrid = 0;
  int gridSize = 36; //12, 24, 36, 48

  @override
  void initState() {
    generateGridList();
    setCurrentGrid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(widget.appBarTitle, context),
      body: getGameScreen(context),
    );
  }

  Widget getGameScreen(BuildContext context){
    if(gridPositionList.isNotEmpty){
      return runningGame(context);
    } else {
      return gameCompleted();
    }
  }

  Widget runningGame(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth >= 1036 ? 6 : 4;

    double gridPadding = 20; // 10 padding on each side
    double totalMainAxisSpacing = (crossAxisCount - 1) * 10; // Spacing between rows
    double availableHeight = screenHeight - gridPadding - totalMainAxisSpacing - 180;
    double mainAxisExtent = availableHeight / (gridSize / crossAxisCount);

    var gridWidth = (screenWidth / crossAxisCount) - 10;
    print('mainAxisExtent=$mainAxisExtent, gridWidth=$gridWidth');
    print('screenWidth=$screenWidth, screenHeight=$screenHeight');

    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        SizedBox(width: gridWidth, height: mainAxisExtent, child: getCurrentGrid()),
        SizedBox(
          height: 8,
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: (1 / .4),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: mainAxisExtent, // Use the calculated height
            ),
            itemCount: gridSize,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    if (index == curGrid) {
                      gridList[index].hide = true;
                      gridPositionList.remove(index);
                      setCurrentGrid();
                    }
                  });
                },
                  child: getGrid(gridList[index].color!, gridList[index].getNumberToShow()),
              );
            },
          ),
        )
      ],
    );
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

  generateGridList() {

    for (int i = 0; i < gridSize; i++) {
      GridNum gridNum = generateRandomGrid();
      // print('i=$i, gridNum=${gridNum}');

      while (gridListContains(gridNum)) {
        //print('while gridListContains: i=${i + 1},${gridNum}');

        gridNum = generateRandomGrid();
      }

      gridList.add(gridNum);
      gridPositionList.add(i);
    }

  }
  
  GridNum generateRandomGrid(){
    List<Color> colorList = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.black,
      Colors.orange,
      Colors.purple,
      Colors.indigo,
      Colors.brown,
      Colors.cyan,
      Colors.pink,
      Colors.teal
    ];

    Color randomColor = colorList[Random().nextInt(colorList.length)];
    int randomNumber = Random().nextInt(9);
    GridNum gridNum = GridNum(randomColor, randomNumber, false);

    return gridNum;
  }

  bool gridListContains(GridNum gridNum){
    try {

      var gridNumFound = gridList.singleWhere((existingGridNum) {
        return existingGridNum.color == gridNum.color && existingGridNum.number == gridNum.number;
      });

      // A GridNum with the same color and number already exists
      //print('gridListContains() gridNumFound=${gridNumFound.toString()}');
      return true;

    } catch (e) {
      // No duplicate found
      //print(e?.toString());
    }

    return false;
  }

  setCurrentGrid(){
    if(gridPositionList.isNotEmpty) {
      int randPos = Random().nextInt(gridPositionList.length);
      curGrid = gridPositionList[randPos];
    } else {
      //game completed
    }
  }

  Widget getCurrentGrid() {
    GridNum gridNum = gridList[curGrid];
    return getGrid(gridNum.color!, gridNum.getNumberToShow());
  }

  Widget getGrid(Color color, String numberToShow) {
    double fontSize = ResponsiveUtils.getScrWidth(context)>=1036 ? 24 :  16;

    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.rectangle,
      ),
      child: Center(
        child: Text(
          numberToShow,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: fontSize),
        ),
      ),
    );
  }
} //buildState

