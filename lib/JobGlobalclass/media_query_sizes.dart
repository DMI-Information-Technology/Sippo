import 'package:flutter/material.dart';

extension MediaQ on BuildContext {
  double fromHeight(double value) {
    return MediaQuery.of(this).size.height / value;
  }

  double fromWidth(double value) {
    return MediaQuery.of(this).size.width / value;
  }
}
