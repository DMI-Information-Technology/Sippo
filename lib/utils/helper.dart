import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../JopCustomWidget/GenderPickerWidget.dart';

void showAlert(BuildContext context, Widget widget) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return widget;
    },
  );
}

String otpPhoneNumberFormat(String phoneNumber, {String countryCode = "218"}) {
  return "+$countryCode${phoneNumber.substring(3)}";
}

String dateTimeFormatter(DateTime dt) {
  return DateFormat("d MMM y 'at' hh:mm a").format(dt);
}

String dobFormatter(DateTime dt) {
  return DateFormat("d MMM y").format(dt);
}

void showMyDatePicker(
  BuildContext context,
  void Function(DateTime?) onDatePickerSelector,
) async {
  final selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );
  if (selectedDate != null) {
    onDatePickerSelector(selectedDate);
  }
}

void showGenderPicker(
  BuildContext context, {
  required void Function(Gender?) onGenderChange,
}) async {
  final selectedGender = await showDialog<Gender>(
    context: context,
    builder: (context) => GenderPickerDialog(),
  );
  if (selectedGender != null) {
    onGenderChange(selectedGender);
  }
}

Future<Timer?> startTimer(int value, void Function(int value) onValueChanged,
    [int until = 0]) async {
  Timer? _timer;
  int counter = value;
  const oneSec = Duration(seconds: 1);
  _timer = await Timer.periodic(
    oneSec,
    (timer) {
      onValueChanged(counter);
      if (counter == until) {
        _timer?.cancel();
        return;
      }
      counter--;
    },
  );
  return _timer;
}
