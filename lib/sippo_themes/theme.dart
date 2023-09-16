import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';

class JobstopMyThemes {
  static final lightTheme = ThemeData(
    primaryColor: Jobstopcolor.black,
    primarySwatch: Jobstopcolor.primarycolorSwatch,
    textTheme: const TextTheme(),
    fontFamily: 'TajawalRegular',
    scaffoldBackgroundColor: Jobstopcolor.backgroudHome,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Jobstopcolor.black),
      elevation: 0,
      titleTextStyle: dmsmedium.copyWith(
        color: Jobstopcolor.black,
        fontSize: 20,
      ),
      color: Jobstopcolor.transparent,
    ),
  );

  static final darkTheme = ThemeData(
    fontFamily: 'DMSansRegular',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Jobstopcolor.black,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Jobstopcolor.white),
      centerTitle: true,
      elevation: 0,
      titleTextStyle: dmsmedium.copyWith(
        color: Jobstopcolor.white,
        fontSize: 18,
      ),
      color: Jobstopcolor.transparent,
    ),
  );
}
