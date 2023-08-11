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

String dateFormatter(DateTime dt) {
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
