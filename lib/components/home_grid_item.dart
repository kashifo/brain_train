import 'package:flutter/material.dart';
import 'get_icons.dart';

Widget getHomeGrid(String title, Color iconColor) {
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
          child: getIcon(title),
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
}