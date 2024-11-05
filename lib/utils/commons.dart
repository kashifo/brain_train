import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String handleNull(String? str){
  if(str==null) {
    return '';
  } else {
    return str;
  }
}

bool isNullOrEmpty(String? str){
  if(str==null || str.isEmpty || str.replaceAll(' ', '').isEmpty ){
    return true;
  }

  return false;
}

Future<void> savePrefString(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

getIntColor(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff$hex' : hex;
  int val = int.parse(hex, radix: 16);
  return Color(val);
}

MaterialColor getMaterialColor(String colorCode) {
  int colorValue = int.parse("0xff$colorCode");
  Color color = Color(colorValue);
  Map<int, Color> shades = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900]
      .asMap()
      .map((key, value) => MapEntry(value, color.withOpacity(1 - (1 - (key + 1) / 10))));

  return MaterialColor(colorValue, shades);
}