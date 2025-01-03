import 'package:flutter/material.dart';

class ResponsiveUtils {

  static double getScrWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  // Check if the device is considered as mobile based on screen width.
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 600;

  // Check if the device is considered as tablet based on screen width.
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width > 600 &&
          MediaQuery.of(context).size.width <= 1200;

  // Check if the device is considered as desktop based on screen width.
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1200;

  static printScreenSize(context){
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    print('width=$width, heigh=$height');
  }

}