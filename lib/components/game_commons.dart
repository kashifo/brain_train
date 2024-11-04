import 'package:flutter/material.dart';

Widget gameCompleted(String gameName){
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/icons/brain_train_logo_wbg_512px.jpg', width: 100, height: 100,),
        Text('Brain Train', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),),
        Text(gameName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        SizedBox(height: 16),
        Text('Congratulations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        Text('You\'ve completed the game', style: TextStyle(fontSize: 18),),
      ],
    ),
  );
}