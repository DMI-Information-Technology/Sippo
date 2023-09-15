import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showAlert(BuildContext context, Widget widget) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return widget;
    },
  );
}

String calculateElapsedTime(int startTimeMillis) {
  int currentTimeMillis = DateTime.now().millisecondsSinceEpoch;
  Duration duration = Duration(
    milliseconds: startTimeMillis - currentTimeMillis,
  );
  if (duration.inDays > 0) {
    return '${duration.inDays} days ago';
  }
  if (duration.inHours > 0) {
    return '${duration.inHours} hours ago';
  }
  if (duration.inMinutes > 0) {
    return '${duration.inMinutes} minutes ago';
  }
  if (duration.inSeconds > 0) {
    return '${duration.inSeconds} seconds ago';
  }
  return 'just now';
}

String otpPhoneNumberFormat(String phoneNumber, {String countryCode = "218"}) {
  return "+$countryCode${phoneNumber.substring(1)}";
}

String dateTimeFormatter(DateTime dt) {
  return DateFormat("d MMM y 'at' hh:mm a").format(dt);
}

String periodicDateFormatter(String? strDate) {
  return strDate != null
      ? DateFormat('MMMM y', 'en_US').format(DateTime.parse(strDate))
      : "Unknown";
}

String dobFormatter(DateTime dt) {
  return DateFormat("d MMM y").format(dt);
}

String customDateFormatter(String dt, String format) {
  try {
    return DateFormat(format).format(DateTime.parse(dt));
  } on FormatException catch (_) {
    return "invalid date format";
  }
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

Future<Timer?> startTimer(
  int value,
  void Function(int value) onValueChanged, {
  int until = 0,
  void Function()? onTimerDone,
}) async {
  Timer? _timer;
  int counter = value;
  const oneSec = Duration(seconds: 1);
  _timer = await Timer.periodic(
    oneSec,
    (timer) {
      onValueChanged(counter);
      if (counter == until) {
        if (onTimerDone != null) onTimerDone();
        timer.cancel();
        return;
      }
      counter--;
    },
  );
  return _timer;
}

bool listEquality<T>(List<T>? list1, List<T>? list2) {
  if (list1 == null && list2 == null) return true;
  if (list1 == null || list2 == null) return false;
  if (list1.length != list2.length) return false;
  return list2.every((e) => list1.contains(e) == true) == true;
}
