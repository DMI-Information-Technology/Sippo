import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';

class JobstopMyThemes {
  static final lightTheme = ThemeData(
    primaryColor: SippoColor.black,
    primarySwatch: SippoColor.primarycolorSwatch,
    useMaterial3: false,
    textTheme: const TextTheme(),
    fontFamily: 'TajawalRegular',
    scaffoldBackgroundColor: SippoColor.backgroudHome,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: SippoColor.black),
      elevation: 0,
      titleTextStyle: dmsmedium.copyWith(
        color: SippoColor.black,
        fontSize: 20,
      ),
      color: SippoColor.transparent,
    ),
  );

  static final darkTheme = ThemeData(
    fontFamily: 'TajawalRegular',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: SippoColor.black,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: SippoColor.white),
      centerTitle: true,
      elevation: 0,
      titleTextStyle: dmsmedium.copyWith(
        color: SippoColor.white,
        fontSize: 18,
      ),
      color: SippoColor.transparent,
    ),
  );
}
