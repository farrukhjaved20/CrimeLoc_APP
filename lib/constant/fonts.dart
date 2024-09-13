import 'package:flutter/material.dart';

class StyleText {
  static const String customfont1 = 'Kollektif';
  //static const String customfont2 = 'Quicksand';

  static TextStyle getRegularStyle({
    String fontFamily = customfont1,
    FontWeight fontWeight = FontWeight.w600,
    FontStyle fontStyle = FontStyle.normal,
    double fontSize = 16.0,
    Color color = Colors.black,
    TextDecoration decoration = TextDecoration.none, // Added decoration
    Color decorationColor = Colors.black, // Added decorationColor
    TextDecorationStyle decorationStyle =
        TextDecorationStyle.solid, // Added decorationStyle
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      fontSize: fontSize,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }

  static TextStyle getBoldStyle({
    String fontFamily = customfont1,
    FontWeight fontWeight = FontWeight.w800,
    FontStyle fontStyle = FontStyle.normal,
    double fontSize = 16.0,
    Color color = Colors.black,
    TextDecoration decoration = TextDecoration.none, // Added decoration
    Color decorationColor = Colors.black, // Added decorationColor
    TextDecorationStyle decorationStyle =
        TextDecorationStyle.solid, // Added decorationStyle
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      fontSize: fontSize,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }
}
