import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

void showAlert(BuildContext context, Widget widget) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return widget;
    },
  );
}

String calculateElapsedTime(DateTime dateTime) {
  final startTimeMillis = dateTime.millisecondsSinceEpoch;
  int currentTimeMillis = DateTime.now().millisecondsSinceEpoch;
  Duration duration = Duration(
    milliseconds: currentTimeMillis - startTimeMillis,
  );
  if (duration.inDays > 0) {
    return '${duration.inDays} ${'days_ago'.tr}';
  }
  if (duration.inHours > 0) {
    return '${duration.inHours} ${"hours_ago".tr}';
  }
  if (duration.inMinutes > 0) {
    return '${duration.inMinutes} ${"minutes_ago".tr}';
  }
  if (duration.inSeconds > 0) {
    return '${duration.inSeconds} ${"seconds_ago".tr}';
  }
  return 'just_now'.tr;
}

String calculateElapsedTimeAR(DateTime dateTime) {
  final startTimeMillis = dateTime.millisecondsSinceEpoch;
  int currentTimeMillis = DateTime.now().millisecondsSinceEpoch;
  Duration duration = Duration(
    milliseconds: currentTimeMillis - startTimeMillis,
  );
  if (duration.inDays > 0) {
    return '${duration.inDays} أيامًا مضت';
  }
  if (duration.inHours > 0) {
    return '${duration.inHours} ساعة مضت';
  }
  if (duration.inMinutes > 0) {
    return '${duration.inMinutes} دقيقة مضت';
  }
  if (duration.inSeconds > 0) {
    return '${duration.inSeconds} ثانية مضت';
  }
  return 'الآن';
}

String? calculateElapsedTimeFromStringDate(String? date) {
  late final DateTime dateTime;
  try {
    if (date == null) {
      throw new Exception('null date is not a valid date string.');
    }
    dateTime = DateTime.parse(date);
    print(dateTime.toString());
  } catch (e, s) {
    print(e);
    print(s);
    return null;
  }
  return calculateElapsedTime(dateTime);
}

double convertBytesToKB(int bytes) {
  return bytes / 1024;
}

String? convertFileSize(int? bytes) {
  if (bytes == null) return null;
  if (bytes < 1024) {
    return '$bytes B';
  } else if (bytes < 1024 * 1024) {
    double kb = convertBytesToKB(bytes);
    return '${kb.toStringAsFixed(2)} KB';
  } else {
    double mb = bytes / (1024 * 1024);
    return '${mb.toStringAsFixed(2)} MB';
  }
}

String otpPhoneNumberFormat(String phoneNumber, {String countryCode = "218"}) {
  return "+$countryCode${phoneNumber.substring(1)}";
}

String? dateTimeFormatter(DateTime? dt) {
  try {
    if (dt == null) return null;
    return DateFormat("d MMM y 'at' hh:mm a").format(dt);
  } catch (e, s) {
    print(s);
    print(e);
    return null;
  }
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
  if (identical(list1, list2)) return true;
  if (list1 == null && list2 == null) return true;
  if (list1 == null || list2 == null) return false;
  if (list1.length != list2.length) return false;
  return list2.every((e) => list1.contains(e) == true) == true;
}

Future<void> lunchMapWithLocation(double? lat, double? long) async {
  if (long == null || lat == null) return;
  try {
    await launchUrl(Uri.parse("http://maps.google.com/?ll=$lat,$long"));
  } catch (e, s) {
    print(e);
    print(s);
  }
}
