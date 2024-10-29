import 'dart:math';
import 'package:brain_train/utils/common_views.dart';
import 'package:flutter/material.dart';
import 'package:brain_train/jigsaw/jigsaw.dart';

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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: simpleAppBar(widget.appBarTitle, context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
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
                    child: const Text('Clear'),
                  ),
                ],
              ),
              JigsawPuzzle(
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
