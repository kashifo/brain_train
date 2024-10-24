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

  GridNum(Color this.color, int this.number, bool this.hide);

  String getNumberToShow(){
    if(hide || number==null){
      return '';
    } else {
      return number.toString();
    }
  }
}

class _FindTheNoState extends State<FindTheNo> {
  List<GridNum> gridList = [];
  List<int> gridPositionList = [];
  int curGrid = 0;
  int gridCount = 24; //12, 24, 36, 48

  @override
  void initState() {
    buildGrid();
    setCurrentGrid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(widget.appBarTitle),
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
    double mainAxisExtent = availableHeight / (gridCount / crossAxisCount);

    return Column(
      children: [
        SizedBox(width: 100, height: 70, child: getCurrentGrid()),
        SizedBox(
          height: 16,
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
            itemCount: gridCount,
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
                child: getGrid(gridList[index].color!, gridList[index].getNumberToShow()!),
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

  buildGrid() {
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

    for (int i = 0; i < gridCount; i++) {
      Color randomColor = colorList[Random().nextInt(colorList.length)];
      int randomNumber = Random().nextInt(9);

      gridList.add(GridNum(randomColor, randomNumber, false));
      gridPositionList.add(i);
    }
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
    return getGrid(gridNum.color!, gridNum.getNumberToShow()!);
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

