import 'package:flutter/material.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';

enum WrapperType { WRAP, VERTICAL }

class ExpandableItemList extends StatelessWidget {
  final itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final bool isExpandable;
  final bool more;
  final VoidCallback onExpandClicked;
  final Color? titleExpandColor;
  final double? spacing;
  final WrapperType widgetType;

  const ExpandableItemList({
    this.isExpandable = false,
    this.more = false,
    this.titleExpandColor,
    this.spacing = 0.0,
    required this.itemCount,
    required this.itemBuilder,
    required this.onExpandClicked,
  }) : widgetType = WrapperType.VERTICAL;

  const ExpandableItemList.wrapBuilder({
    this.isExpandable = false,
    this.more = false,
    this.titleExpandColor,
    this.spacing = 0.0,
    required this.itemCount,
    required this.itemBuilder,
    required this.onExpandClicked,
  }) : widgetType = WrapperType.WRAP;

  Widget _wrapperBuilder(BuildContext context, WrapperType wrapperType) {
    final count = more
        ? itemCount
        : itemCount > 0
            ? 1
            : 0;
    List<Widget> listOfWidgets = [
      for (var i = 0; i < count; i++) ...[
        itemBuilder(context, i),
        wrapperType == WrapperType.WRAP
            ? SizedBox(width: spacing)
            : SizedBox(height: spacing),
      ],
      if (isExpandable && itemCount != 0)
        TextButton(
          onPressed: onExpandClicked,
          child: Text(
            more ? 'Show Less' : 'Show More',
            style: dmsregular.copyWith(
              color: titleExpandColor ?? Jobstopcolor.grey,
            ),
          ),
        ),
    ];
    switch (wrapperType) {
      case WrapperType.WRAP:
        return Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          alignment: WrapAlignment.start,
          children: listOfWidgets,
        );
      case WrapperType.VERTICAL:
        return Column(children: listOfWidgets);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return SizedBox(width: width, child: _wrapperBuilder(context, widgetType));
  }
}
