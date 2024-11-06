import 'package:flutter/material.dart';

AppBar simpleAppBar(String title, BuildContext context) {
  return AppBar(
    title: Text(title),
    automaticallyImplyLeading: false,
    elevation: 2.0,
    actions: [
      InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(
            Icons.close
          ),
        ),
      )
    ],
  );
}
