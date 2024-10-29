import 'package:brain_train/utils/common_views.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatefulWidget {
  const EmptyScreen({super.key, required this.appBarTitle});
  final String appBarTitle;

  @override
  State<EmptyScreen> createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(widget.appBarTitle, context),
      body: const Center(
        child: Text('This screen is not ready yet.'),
      ),
    );
  }
}
