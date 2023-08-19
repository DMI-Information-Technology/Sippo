import 'package:flutter/material.dart';

class FontSize {
  static const double _labelSize = 32;
  static const double _titleSize = 12;
  static const double _paragraphSize = 24;
  static const double _buttonFontSize = 18;

  FontSize._();

  static double labelFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width / _labelSize;
  }

  static double labelFontSize2(BuildContext context) {
    return MediaQuery.of(context).size.width / (_labelSize + 3);
  }

  static double labelFontSize3(BuildContext context) {
    return MediaQuery.of(context).size.width / (_labelSize + 6);
  }

  static double titleFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width / _titleSize;
  }

  static double titleFontSize2(BuildContext context) {
    return MediaQuery.of(context).size.width / (_titleSize + 3);
  }

  static double titleFontSize3(BuildContext context) {
    return MediaQuery.of(context).size.width / (_titleSize + 6);
  }

  static double titleFontSize4(BuildContext context) {
    return MediaQuery.of(context).size.width / (_titleSize + 9);
  }

  static double titleFontSize5(BuildContext context) {
    return MediaQuery.of(context).size.width / (_titleSize + 12);
  }

  static double titleFontSize6(BuildContext context) {
    return MediaQuery.of(context).size.width / (_titleSize + 16);
  }

  static double paragraphFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width / _paragraphSize;
  }

  static double paragraphFontSize2(BuildContext context) {
    return MediaQuery.of(context).size.width / (_paragraphSize + 3);
  }

  static double paragraphFontSize3(BuildContext context) {
    return MediaQuery.of(context).size.width / (_paragraphSize + 6);
  }

  static double buttonFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width / _buttonFontSize;
  }

  static double buttonFontSize2(BuildContext context) {
    return MediaQuery.of(context).size.width / (_buttonFontSize + 3);
  }

  static double buttonFontSize3(BuildContext context) {
    return MediaQuery.of(context).size.width / (_buttonFontSize + 6);
  }
}
