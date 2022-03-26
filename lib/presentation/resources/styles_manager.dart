import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(fontSize: fontSize, fontFamily: fontFamily, color: color);
}

// regular styles
TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontManager.fontFamily, FontWeightManager.regular, color);
}

// light text style
TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontManager.fontFamily, FontWeightManager.light, color);
}

// medium text style
TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontManager.fontFamily, FontWeightManager.medium, color);
}

// semiBold text style
TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontManager.fontFamily, FontWeightManager.semiBold, color);
}

// bold text style
TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontManager.fontFamily, FontWeightManager.bold, color);
}
