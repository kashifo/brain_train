import 'dart:math';

import 'package:flutter/material.dart';

class FindTheNo extends StatefulWidget {
  const FindTheNo({super.key, required this.appBarTitle});
  final String appBarTitle;

  @override
  State<FindTheNo> createState() => _FindTheNoState();
}

class _FindTheNoState extends State<FindTheNo> {
  List<Widget> widgetList = [];
  int curGrid = 0;

  @override
  void initState() {
    buildGrid();
    curGrid = Random().nextInt(widgetList.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Container(
            width: 100,
              height: 70,
              child: widgetList[curGrid]
          ),
          SizedBox(
            height: 16,
          ),
          GridView.extent(
            shrinkWrap: true,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            physics: const ScrollPhysics(),
            scrollDirection: Axis.vertical,
            maxCrossAxisExtent: 100,
            children: widgetList,
          )
        ],
      ),
    );
  }

  buildGrid(){
    for(int i=0; i<25; i++){
      widgetList.add( getGrid() );
    }
  }

  Widget getRandomGrid(){
    int randomNumber = Random().nextInt(widgetList.length);
    return widgetList[ randomNumber ];
  }

  Widget getGrid() {
    List<Color> colorList = [Colors.red, Colors.blue, Colors.green, Colors.black, Colors.orange, Colors.purple, Colors.indigo, Colors.brown, Colors.cyan, Colors.pink, Colors.teal];
    int randomColor = Random().nextInt(colorList.length);
    int randomNumber = Random().nextInt(9);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration: BoxDecoration(
        color: colorList[randomColor],
        shape: BoxShape.rectangle,
      ),
      child: Center(
        child: Text(
          randomNumber.toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}

/*GridView.builder(
              // Set padding and spacing between cards.
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // Set the number of columns based on the device's screen size.
                crossAxisCount: 5,
                // Set the aspect ratio of each card.
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              // Set the number of items in the grid view.
              itemCount: 25,
              shrinkWrap: true,
              // Disable scrolling in the grid view.
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                InkWell(
                  onTap: (){
                    print('onTap-$index');
                  },
                  child: widgetList[index],
                );
              })*/

/*
GridView.extent(
shrinkWrap: true,
mainAxisSpacing: 8,
crossAxisSpacing: 8,
padding: const EdgeInsets.symmetric(horizontal: 8),
physics: const ScrollPhysics(),
scrollDirection: Axis.vertical,
maxCrossAxisExtent: 100,
children: widgetList,
),*/
