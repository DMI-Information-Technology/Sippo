import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';

class RoundedBorderRadiusCardWidget extends StatelessWidget {
  const RoundedBorderRadiusCardWidget({
    super.key,
    required this.child,
    this.margin = EdgeInsets.zero,
    this.color = Colors.white,
  });

  final Color? color;
  final EdgeInsets? margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // double height = size.height;
    return Card(
      margin: margin,
      color: color,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding:
            EdgeInsets.all(context.fromWidth(CustomStyle.roundedCardPadding)),
        child: child,
      ),
    );
  }
}
