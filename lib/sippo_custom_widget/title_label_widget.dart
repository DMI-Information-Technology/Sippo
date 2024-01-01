import 'package:flutter/material.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';

import '../JobGlobalclass/jobstopfontstyle.dart';

class TitleLabelWidget extends StatelessWidget {
  final String data;
  final Key? key;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final double? fontSize;

  // Default values for properties if not provided
  const TitleLabelWidget(
    this.data, {
    this.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      key: key,
      style: style ??
          dmsbold.copyWith(fontSize: fontSize ?? FontSize.title5(context)),
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
    );
  }
}
