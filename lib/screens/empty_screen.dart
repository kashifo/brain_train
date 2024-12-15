import 'package:brain_train/components/simple_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final appBarTitle = args['appBarTitle'];

    return Scaffold(
      appBar: simpleAppBar(appBarTitle, context),
      body: const Center(
        child: Text('This screen is not ready yet.'),
      ),
    );
  }
}
