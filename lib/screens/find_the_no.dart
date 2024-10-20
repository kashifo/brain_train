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

  GridNum(Color this.color, int this.number);
}

class _FindTheNoState extends State<FindTheNo> {
  List<GridNum> gridList = [];
  int curGrid = 0;

  @override
  void initState() {
    buildGrid();
    curGrid = Random().nextInt(gridList.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(widget.appBarTitle),
      body: Column(
        children: [
          SizedBox(width: 100, height: 70, child: getCurrentGrid()),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveUtils.getScrWidth(context)>=1036 ? 6 : 4,
                childAspectRatio: (1/.4),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 36,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    ResponsiveUtils.printScreenSize(context);

                    setState(() {
                      curGrid = Random().nextInt(gridList.length);
                    });
                  },
                  child: getGrid(gridList[index].color!, gridList[index].number!),
                );
              },
            ),
          )
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

    for (int i = 0; i < 36; i++) {
      Color randomColor = colorList[Random().nextInt(colorList.length)];
      int randomNumber = Random().nextInt(9);

      gridList.add(GridNum(randomColor, randomNumber));
    }
  }

  Widget getCurrentGrid() {
    GridNum gridNum = gridList[curGrid];
    return getGrid(gridNum.color!, gridNum.number!);
  }

  Widget getGrid(Color color, int number) {
    double fontSize = ResponsiveUtils.getScrWidth(context)>=1036 ? 24 :  16;

    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.rectangle,
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: fontSize),
        ),
      ),
    );
  }
} //buildState
