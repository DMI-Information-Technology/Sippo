import 'package:flutter/material.dart';

class ConditionalWidget<T> extends StatelessWidget {
  const ConditionalWidget(
    this.condition, {
    super.key,
    this.data,
    this.guaranteedBuilder,
    this.avoidBuilder,
  }) : this.predict = null;

  const ConditionalWidget.predict(
    this.predict, {
    super.key,
    this.data,
    this.guaranteedBuilder,
    this.avoidBuilder,
  }) : this.condition = false;

  final T? data;
  final Widget Function(BuildContext context, T? data)? guaranteedBuilder;
  final Widget Function(BuildContext context, T? data)? avoidBuilder;
  final bool Function(T? data)? predict;
  final bool condition;

  Widget _buildCases(BuildContext context) {
    late final bool result;
    if (predict != null) {
      result = predict!(data);
    } else {
      result = condition;
    }
    return switch (result) {
      true => guaranteedBuilder != null
          ? guaranteedBuilder!(context, data)
          : const SizedBox.shrink(),
      false => avoidBuilder != null
          ? avoidBuilder!(context, data)
          : const SizedBox.shrink(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return _buildCases(context);
  }
}
