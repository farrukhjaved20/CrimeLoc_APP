import 'package:flutter/material.dart';

class SizeConfig {
  // ignore: avoid_init_to_null
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;
  static late bool isAndroid;
  static late double kAppBarWithStatusBarHeight;
  static late double kBottomBarWithNavigationBarHeight;
  static late double topPadding;
  static late double bottomPadding;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;

    topPadding = _mediaQueryData.padding.top;
    bottomPadding = _mediaQueryData.padding.bottom;
    double statusBarHeight = _mediaQueryData.padding.top;
    double appBarHeight = kToolbarHeight;
    kAppBarWithStatusBarHeight = statusBarHeight + appBarHeight;
    double bottomBarHeight = _mediaQueryData.padding.bottom;
    double appNavigationBarHeight = kBottomNavigationBarHeight;
    kBottomBarWithNavigationBarHeight =
        bottomBarHeight + appNavigationBarHeight;
    isAndroid = Theme.of(context).platform == TargetPlatform.iOS ? false : true;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;

  // 375 is the layout width that designer use
  return (inputWidth / 428.0) * screenWidth;
}
