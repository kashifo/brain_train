import 'package:brain_train/utils/common_views.dart';
import 'package:flutter/material.dart';
import 'package:brain_train/jigsaw/jigsaw.dart';

class JigsawDemo extends StatelessWidget {
  const JigsawDemo({super.key, required this.appBarTitle});

  final String appBarTitle;

  @override
  Widget build(BuildContext context) {
    final puzzleKey = GlobalKey<JigsawWidgetState>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: simpleAppBar(appBarTitle),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                image: const AssetImage('assets/images/kas_fizz_300.jpg'),
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
  }
}
