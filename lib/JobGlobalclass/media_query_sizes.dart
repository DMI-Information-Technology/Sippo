import 'package:flutter/material.dart';

extension MediaQ on BuildContext {
  double fromHeight(double value) {
    return MediaQuery.sizeOf(this).height / value;
  }

  double fromWidth(double value) {
    return MediaQuery.sizeOf(this).width / value;
  }
}
