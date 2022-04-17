import 'package:flutter/material.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(fontSize: fontSize, fontFamily: fontFamily, color: color);
}

// REGULAR TEXT STYLES
TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontManager.fontFamily, FontWeightManager.regular, color);
}

// LIGHT TEXT STYLES
TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontManager.fontFamily, FontWeightManager.light, color);
}

// MEDIUM TEXT STYLES
TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontManager.fontFamily, FontWeightManager.medium, color);
}

// SEMI BOLD TEXT STYLES
TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontManager.fontFamily, FontWeightManager.semiBold, color);
}

// BOLD TEXT STYLES
TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontManager.fontFamily, FontWeightManager.bold, color);
}
