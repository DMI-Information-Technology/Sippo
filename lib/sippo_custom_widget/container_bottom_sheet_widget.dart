import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';

import '../JobGlobalclass/sippo_customstyle.dart';

enum ContainerType {
  statefulBuilder,
  v_list,
  // h_list,
}

class ContainerBottomSheetWidget extends StatelessWidget {
  const ContainerBottomSheetWidget({
    super.key,
    required this.children,
    this.notchColor,
  })  : this.builder = null,
        conType = ContainerType.v_list;

  // const ContainerBottomSheetWidget.horizontal({
  //   super.key,
  //   required this.children,
  // })  : this.builder = null,
  //       conType = ContainerType.h_list;

  const ContainerBottomSheetWidget.statefulBuilder({
    super.key,
    required this.builder,
    this.notchColor,
  })  : this.children = null,
        conType = ContainerType.statefulBuilder;
  final Color? notchColor;
  final ContainerType conType;
  final List<Widget>? children;
  final Widget Function(BuildContext, void Function(void Function()))? builder;

  Widget _buildWidget() {
    return switch (conType) {
      ContainerType.statefulBuilder => builder != null
          ? StatefulBuilder(
              builder: (context, setState) => builder!(context, setState),
            )
          : const SizedBox.shrink(),
      ContainerType.v_list => children != null
          ? Column(children: children!)
          : const SizedBox.shrink(),
      // case ContainerType.h_list:
      //   return children != null
      //       ? Row(children: children!)
      //       : const SizedBox.shrink();
    };
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: MediaQuery.of(context).viewInsets.top,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
          Container(
            height: 5.0,
            width: 50.0,
            decoration: BoxDecoration(
              color: notchColor ?? Colors.grey[400],
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 32),
            child: Divider(thickness: height / 256, color: Colors.grey[300]),
          ),
          _buildWidget(),
          SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
        ],
      ),
    );
  }
}
