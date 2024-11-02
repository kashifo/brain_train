import 'package:flutter/material.dart';
import '../utils/common_views.dart';

class SlidingPuzzle extends StatefulWidget {
  const SlidingPuzzle({super.key, required this.appBarTitle});
  final String appBarTitle;

  @override
  State<SlidingPuzzle> createState() => _SlidingPuzzleState();
}

class _SlidingPuzzleState extends State<SlidingPuzzle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(widget.appBarTitle, context),
      body: const Center(
        child: Text('This game is under development'),
      ),
    );
  }
}
