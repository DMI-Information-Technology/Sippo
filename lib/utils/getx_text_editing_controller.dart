import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetXTextEditingController {
  final controller = TextEditingController(text: "");
  final _text = "".obs;

  String get text => controller.text.trim();

  void set text(String value) => controller.text = value;

  bool get isTextEmpty => _text.trim().isEmpty;

  GetXTextEditingController() {
    controller.addListener(_textListener);
  }

  void clear() => controller.clear();

  void _textListener() {
    _text.value = controller.text;
  }

  void dispose() {
    controller.removeListener(_textListener);
    controller.dispose();
  }
}
