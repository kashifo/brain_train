import 'package:flutter/material.dart';

AppBar simpleAppBar(String title) {
  return AppBar(
    title: Text(title),
    automaticallyImplyLeading: true,
    centerTitle: true,
    elevation: 2.0,
  );
}
