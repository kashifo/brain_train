import 'package:brain_train/components/simple_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key, required this.appBarTitle});

  final String appBarTitle;

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(widget.appBarTitle, context),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(16),
        children: [
          SvgPicture.asset(
            'assets/icons/folder_search.svg',
            colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
          ),
          Text('This screen is not ready yet.'),
          gridItem(context, 'title', 'brain.svg', Colors.blue),
          gridItem(context, 'title', 'matrix.svg', Colors.red),
          gridItem(context, 'title', 'puzzles.svg', Colors.blue),
          gridItem(context, 'title', 'brain_gear.svg', Colors.blue),
          gridItem(context, 'title', 'folder_search.svg', Colors.blue),
          gridItem(context, 'title', 'magnifier.svg', Colors.blue),
          gridItem(context, 'title', 'puzzle.svg', Colors.blue),
          gridItem(context, 'title', 'puzzle_round.svg', Colors.blue),
          gridItem(context, 'title', 'slide_button.svg', Colors.blue),
        ],
      ),
    );
  }

  Widget gridItem(
      BuildContext context, String title, var icon, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 5,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.2))
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor,
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 5,
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(0.2))
              ],
            ),
            child: SvgPicture.asset(
              'assets/icons/$icon',
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              width: 35,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  } //gridItem
}
