import 'package:flutter/material.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';

enum PaddingType { vertical, horizontal, all }

enum RadiusType { top, bottom, all }

class RoundedBorderRadiusCardWidget extends StatelessWidget {
  const RoundedBorderRadiusCardWidget({
    super.key,
    required this.child,
    this.margin,
    this.color = Colors.white,
    this.paddingType = PaddingType.all,
    this.paddingValue,
    this.radiusValue,
    this.padding,
  }) : radiusType = RadiusType.all;

  const RoundedBorderRadiusCardWidget.top({
    super.key,
    required this.child,
    this.margin,
    this.color = Colors.white,
    this.paddingType = PaddingType.all,
    this.paddingValue,
    this.radiusValue,
    this.padding,
  }) : radiusType = RadiusType.top;

  const RoundedBorderRadiusCardWidget.bottom({
    super.key,
    required this.child,
    this.margin,
    this.color = Colors.white,
    this.paddingType = PaddingType.all,
    this.paddingValue,
    this.radiusValue,
    this.padding,
  }) : radiusType = RadiusType.bottom;

  final RadiusType radiusType;
  final EdgeInsets? padding;
  final PaddingType paddingType;
  final Color? color;
  final EdgeInsets? margin;
  final double? paddingValue;
  final Widget child;
  final double? radiusValue;

  EdgeInsetsGeometry _getPaddingType(BuildContext context) {
    switch (paddingType) {
      case PaddingType.vertical:
        return EdgeInsets.symmetric(
          vertical: paddingValue ??
              context.fromWidth(
                CustomStyle.roundedCardPadding,
              ),
        );

      case PaddingType.horizontal:
        return EdgeInsets.symmetric(
          horizontal: paddingValue ??
              context.fromWidth(
                CustomStyle.roundedCardPadding,
              ),
        );

      case PaddingType.all:
        return EdgeInsets.all(
          paddingValue ??
              context.fromWidth(
                CustomStyle.roundedCardPadding,
              ),
        );
    }
  }

  BorderRadius _borderRadius(BuildContext context) {
    return switch (radiusType) {
      RadiusType.top => BorderRadius.vertical(
          top: Radius.circular(radiusValue ?? 25),
        ),
      RadiusType.bottom => BorderRadius.vertical(
          bottom: Radius.circular(radiusValue ?? 25),
        ),
      RadiusType.all => BorderRadius.circular(radiusValue ?? 25),
    };
  }

  @override
  Widget build(BuildContext context) {
    // double height = size.height;
    return Card(
      margin: margin ?? EdgeInsets.zero,
      color: color,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: _borderRadius(context)),
      child: Padding(
        padding: padding ?? _getPaddingType(context),
        child: child,
      ),
    );
  }
}
