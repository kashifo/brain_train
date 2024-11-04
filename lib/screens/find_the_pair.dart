import 'dart:math';
import 'package:flutter/material.dart';
import '../components/game_commons.dart';
import '../models/ImgGrid.dart';

class FindThePair extends StatefulWidget {
  const FindThePair({super.key, required this.appBarTitle});
  final String appBarTitle;

  @override
  State<FindThePair> createState() => _FindThePairState();
}

class _FindThePairState extends State<FindThePair> {
  List<String> rawImgList = ['mark_face.png', 'elon_musk.jpg', 'steve.jpg', 'linus.jpg', 'bill.jpg', 'ola_s1x.jpg', 'gilfoyle.jpg', 'erlich.jpg', 'richard.jpg', 'jared.jpg', 'jan.jpg', 'monica.jpg', 'kas_fizz_300.jpg'];
  int gridSize = 24;
  int correctClicks = 0;
  List<ImgGrid> imgGridList = [];
  List<ImgGrid> clickList = [];
  bool _showFrontSide = true;
  bool showAnim = false;

  @override
  void initState() {
    generateGridList();
    super.initState();
  }

  generateGridList(){
    List<String> imgPairList = [];
    rawImgList = rawImgList.sublist(0, gridSize~/2);
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
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        automaticallyImplyLeading: false,
        elevation: 2.0,
        actions: [
          Switch(
            value: showAnim,
            onChanged: (value) {
              setState(() {
                showAnim = value;
              });
            },
          ),
          SizedBox(width: 16),
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                  Icons.close
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: getGameScreen(context),
    );
  }

  Widget getGameScreen(BuildContext context){
    if(correctClicks==(gridSize/2)){
      return gameCompleted(widget.appBarTitle);
    } else {
      return runningGame(context);
    }
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
                  if(imgGridList[index].show) {
                    //prevent click for already showing item
                    return;
                  }

                    if (clickList.isEmpty) {

                      setState(() {
                        clickList.add(imgGridList[index]);
                        imgGridList[index].show = true;
                      });

                    } else {

                      if (clickList[0].imgPath.compareTo(imgGridList[index].imgPath) == 0) {

                        setState(() {
                          imgGridList[index].show = true;
                          correctClicks++;
                          clickList.clear();
                        });

                      } else {
                        incorrectClick(index);
                      }

                    }
                },
                child: !showAnim ? getGrid(imgGridList[index])
                : Center(
                  child: Container(
                    constraints: BoxConstraints.tight(Size.square(gridWidth)),
                    child: _buildFlipAnimation(index),
                  ),
                ),
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

  Widget _buildFlipAnimation(int index) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 800),
      transitionBuilder: _buildFlipTransition,
      layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
      switchInCurve: Curves.easeInBack,
      switchOutCurve: Curves.easeInBack.flipped,
      child: imgGridList[index].show ? _buildFront(index) : _buildRear(),
    );
  }

  Widget _buildFlipTransition(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget?.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: (Matrix4.rotationY(value)..setEntry(3, 0, tilt)),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  Widget _buildFront(int index) {
    return _buildLayout(
      key: ValueKey(true),
      child: Center(
        child: Image.asset(
          'assets/images/classic_puzzle/${imgGridList[index].imgPath}',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildRear() {
    return _buildLayout(
      key: ValueKey(false),
      child: Center(
        child: Image.asset(
          'assets/images/ubuntu_plain.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildLayout({
    required Key key,
    required Widget child,
  }) {
    return ClipRRect(
      key: key,
      borderRadius: BorderRadius.circular(16.0),
      child: child,
    );
  }

}
