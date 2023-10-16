import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';

import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';

class NetworkStatusNonWidget extends StatelessWidget {
  const NetworkStatusNonWidget(
      {super.key,
      this.color = Colors.black87,
      this.top,
      this.bottom,
      this.left,
      this.right,
      this.isPositioned = true});

  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final Color color;
  final bool isPositioned;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    final child = SafeArea(
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: context.fromHeight(CustomStyle.connectionLostHeight),
        decoration: BoxDecoration(
          color: color,
        ),
        child: AutoSizeText(
          'network connection is lost',
          style: dmsregular.copyWith(
            color: Colors.red,
            fontSize: FontSize.label3(context),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
    return isPositioned
        ? Positioned(
            top: top ?? 0,
            bottom: bottom,
            left: left,
            right: right,
            child: child,
          )
        : child;
  }
}
