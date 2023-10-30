import 'package:flutter/material.dart';

class ConditionalWidget<T> extends StatelessWidget {
  const ConditionalWidget(
    this.condition, {
    super.key,
    this.data,
    this.guaranteedBuilder,
    this.avoidBuilder,
    this.isLoading = false,
    this.onLoadingProgress,
  }) : this.predict = null;

  const ConditionalWidget.predict(
    this.predict, {
    super.key,
    this.data,
    this.guaranteedBuilder,
    this.avoidBuilder,
    this.isLoading = false,
    this.onLoadingProgress,
  }) : this.condition = false;

  final T? data;
  final Widget? Function(BuildContext context, T? data)? guaranteedBuilder;
  final Widget? Function(BuildContext context, T? data)? avoidBuilder;
  final Widget? Function(BuildContext context, Widget progress)?
      onLoadingProgress;
  final bool Function(T? data)? predict;
  final bool condition;
  final bool isLoading;
  static const empty = const SizedBox.shrink();
  static const circularIndicatorProgress =
      const Center(child: CircularProgressIndicator());

  Widget _buildCases(BuildContext context) {
    late final bool result;
    if (predict != null) {
      result = predict!(data);
    } else {
      result = condition;
    }
    if (isLoading)
      return onLoadingProgress != null
          ? onLoadingProgress?.call(context, circularIndicatorProgress) ??
              circularIndicatorProgress
          : circularIndicatorProgress;
    return Visibility(
      visible: result,
      child: guaranteedBuilder != null
          ? guaranteedBuilder!(context, data) ?? empty
          : empty,
      replacement:
          avoidBuilder != null ? avoidBuilder!(context, data) ?? empty : empty,
    );
    // return switch (result) {
    //   true => guaranteedBuilder != null
    //       ? guaranteedBuilder!(context, data) ?? empty
    //       : empty,
    //   false =>
    //     avoidBuilder != null ? avoidBuilder!(context, data) ?? empty : empty,
    // };
  }

  @override
  Widget build(BuildContext context) {
    return _buildCases(context);
  }
}
