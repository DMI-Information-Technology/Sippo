import 'package:flutter/material.dart';

import 'jobstopcolor.dart';

const enabledUnderLineBorder = UnderlineInputBorder(
  borderSide: BorderSide(color: Jobstopcolor.grey, width: 1),
);

const focusedUnderLineBorder = UnderlineInputBorder(
  borderSide: BorderSide(color: Jobstopcolor.primarycolor, width: 2),
);

const errorUnderLineBorder = UnderlineInputBorder(
  borderSide: BorderSide(color: Jobstopcolor.red, width: 2),
);

OutlinedBorder circularBorderedShapeButton(double radius) =>
    ContinuousRectangleBorder(borderRadius: BorderRadius.circular(radius));

// These values are used with media queries,
// where each value from these measurements is divided by the dimensions of the screen's width and height.
// The smaller value used, giving you larger elements
class CustomStyle {
  static const xs = 16.0;
  static const s = 24.0;
  static const m = 32.0;
  static const l = 36.0;
  static const xl = 42.0;
  static const xxl = 48.0;
  static const xxxl = 64.0;
  static const huge = 72.0;
  static const huge2 = 128.0;
  static const halfFullSize = 2.0;
  static const paddingValue = 32.0;
  static const paddingValue2 = 36.0;
  static const verticalSpaceBetween = 36.0;
  static const spaceBetween = 36.0;
  static const paddingBottomButton = 32.0;
  static const roundedCardPadding = 21.0;
  static const jobCardWidth = 1.4;
  static const imageSize = 6.0;
  static const imageSize1 = 10.0;
  static const imageSize2 = 14.0;
  static const imageSize3 = 16.0;
  static const overBy3 = 3.0;
  static const overBy2 = 2.0;
  static const inputBorderedSize = 13.5;
  static const expandedTopBarHeight = 3.5;
  static const expandedTopBarHeight2 = 4.0;
  static const expandedTopBarHeight3 = 4.5;
  static const connectionLostHeight = 25.0;

}
