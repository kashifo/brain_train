import 'dart:math';
import 'package:brain_train/components/simple_app_bar.dart';
import 'package:brain_train/screens/jigsaw/jigsaw.dart';
import 'package:flutter/material.dart';

class JigsawDemo extends StatefulWidget {
  const JigsawDemo({super.key, required this.appBarTitle});

  final String appBarTitle;

  @override
  State<JigsawDemo> createState() => _JigsawDemoState();
}

class _JigsawDemoState extends State<JigsawDemo> {
  String puzzleImg = 'assets/images/kas_fizz_300.jpg';

  @override
  Widget build(BuildContext context) {
    final puzzleKey = GlobalKey<JigsawWidgetState>();
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;
    print('scrWidth=$scrWidth, scrHeight=$scrHeight');

    var gridWidth = scrWidth-32;
    var gridHeight = scrHeight-150;

    //w=533,h=771, w=773,h=771
    //w=583,h=809 to w=h (809) w is 72% of height
    if(scrHeight < scrWidth){
      gridWidth = 0.6 * scrHeight;

      /*if(scrHeight+(0.3*scrWidth) < scrWidth){
        print('if(scrHeight+(0.3*scrWidth) < scrWidth)');
        gridWidth = 0.4*scrHeight;
      }*/
      if(scrWidth-scrHeight < 0.7*scrWidth){
        print('if(scrWidth-scrHeight < 0.7*scrWidth)');
        gridWidth = 0.5*scrHeight;
      }

      if(scrHeight < 0.42*scrWidth){
        print('if(scrHeight < 0.4*scrWidth)');
        gridWidth = 0.4 * scrHeight;
      }
    } else if(scrWidth < scrHeight){
      gridWidth = scrWidth;

      //scrHeight doesn't have 30% more than scrWidth
      if(scrHeight-scrWidth < 0.7*scrHeight){
        print('if(scrHeight-scrWidth < 0.7*scrHeight){');
        gridWidth = 0.6*scrHeight;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: simpleAppBar(widget.appBarTitle, context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          puzzleImg = getRandomPic();
                          puzzleKey.currentState!.reset();
                        });
                      },
                      child: const Text('New'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () async {
                        await puzzleKey.currentState!.generate();
                      },
                      child: const Text('Generate'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        puzzleKey.currentState!.reset();
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  width: gridWidth,
                  // height: gridHeight,
                  child: JigsawPuzzle(
                    gridSize: 3,
                    image: AssetImage(puzzleImg),
                    onFinished: () {
                      // ignore: avoid_print
                      print('finished!');
                    },
                    // ignore: avoid_redundant_argument_values
                    snapSensitivity: .5,
                    // Between 0 and 1
                    puzzleKey: puzzleKey,
                    onBlockSuccess: () {
                      // ignore: avoid_print
                      print('block success!');
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }//build

  String getRandomPic(){
    List<String> pics = ['mark_face.png', 'elon_musk.jpg', 'steve.jpg', 'linus.jpg', 'bill.jpg', 'ola_s1x.jpg', 'gilfoyle.jpg', 'erlich.jpg', 'richard.jpg', 'jared.jpg', 'jan.jpg', 'monica.jpg', 'kas_fizz_300.jpg'];
    var nextInt = Random().nextInt( pics.length );
    return 'assets/images/classic_puzzle/${pics[nextInt]}';
  }

}
