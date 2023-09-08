import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';

enum PaddingType { vertical, horizontal, all }

class RoundedBorderRadiusCardWidget extends StatelessWidget {
  const RoundedBorderRadiusCardWidget({
    super.key,
    required this.child,
    this.margin = EdgeInsets.zero,
    this.color = Colors.white,
    required this.paddingType,
    this.paddingValue,
  });

  final PaddingType paddingType;
  final Color? color;
  final EdgeInsets? margin;
  final double? paddingValue;
  final Widget child;

  EdgeInsetsGeometry _getPaddingType(BuildContext context) {
    switch (paddingType) {
      case PaddingType.vertical:
        return EdgeInsets.symmetric(
          vertical:
              paddingValue ?? context.fromWidth(CustomStyle.roundedCardPadding),
        );

      case PaddingType.horizontal:
        return EdgeInsets.symmetric(
          horizontal:
              paddingValue ?? context.fromWidth(CustomStyle.roundedCardPadding),
        );

      case PaddingType.all:
        return EdgeInsets.all(
          paddingValue ?? context.fromWidth(CustomStyle.roundedCardPadding),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    // double height = size.height;
    return Card(
      margin: margin,
      color: color,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: _getPaddingType(context),
        child: child,
      ),
    );
  }
}
