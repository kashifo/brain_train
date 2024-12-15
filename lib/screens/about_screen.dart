import 'package:brain_train/components/simple_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final appBarTitle = args['appBarTitle'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: simpleAppBar(appBarTitle, context),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/brain_train_logo_wbg_512px.jpg', width: 100, height: 100,),
            Text('Brain Train', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),),
            Text('Version 1.2', style: TextStyle(fontSize: 14),),
            SizedBox(height: 16),
            Text('Developed By:', style: TextStyle(fontSize: 14),),
            Text('Kashif Anwaar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
