import 'package:brain_train/screens/jigsaw/jigsaw.dart';
import 'package:flutter/material.dart';

class JigsawScreen extends StatefulWidget {
  const JigsawScreen({super.key});

  @override
  State<JigsawScreen> createState() => _JigsawScreenState();
}

class _JigsawScreenState extends State<JigsawScreen> {

  final puzzleKey = GlobalKey<JigsawWidgetState>();

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
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
                gridSize: 5,
                image: const AssetImage('assets/images/kas_fizz_300.jpg'),
                onFinished: () {
                  // ignore: avoid_print
                  print('finished!');
                },
                // ignore: avoid_redundant_argument_values
                snapSensitivity: .5, // Between 0 and 1
                puzzleKey: puzzleKey,
                onBlockSuccess: () {
                  // ignore: avoid_print
                  print('block success!');
                },
              )
            ],
          ),
        ),
      );

  }
}
