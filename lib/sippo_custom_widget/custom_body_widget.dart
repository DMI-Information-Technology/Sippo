import 'package:flutter/material.dart';

class CustomBodyWidget extends StatefulWidget {
  const CustomBodyWidget({
    super.key,
    required this.expandedAppBarHeight,
    this.toolBarHeight,
    this.expandedAppBar,
    this.contentPadding,
    this.child,
    this.extraAppBarHeight = 0.0,
  })  : this.itemCount = 0,
        this.itemBuilder = null;

  CustomBodyWidget.itemBuilder({
    super.key,
    required this.expandedAppBarHeight,
    this.toolBarHeight,
    this.expandedAppBar,
    this.contentPadding,
    this.extraAppBarHeight = 0.0,
    this.itemCount = 0,
    this.itemBuilder,
  }) : this.child = null;

  // final  children;
  final int itemCount;
  final double extraAppBarHeight;
  final double expandedAppBarHeight;
  final double? toolBarHeight;
  final Widget? expandedAppBar;
  final EdgeInsets? contentPadding;
  final Widget? child;
  final Widget? Function(BuildContext context, int index)? itemBuilder;

  @override
  State<CustomBodyWidget> createState() => _CustomBodyWidgetState();
}

class _CustomBodyWidgetState extends State<CustomBodyWidget> {
  double expandedHeight = 0; // A default value
  final GlobalKey _flexibleChildKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    expandedHeight = widget.expandedAppBarHeight;
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => _updateExpandedHeight());
  }

  // void _updateExpandedHeight() {
  //   final RenderBox renderBox =
  //       _flexibleChildKey.currentContext!.findRenderObject() as RenderBox;
  //   final childHeight = renderBox.size.height;
  //   if (childHeight > expandedHeight) {
  //     print("CustomBodyWidget expandedHeight: $expandedHeight");
  //     print("CustomBodyWidget childHeight: $childHeight");
  //     expandedHeight = childHeight;
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // print("expandedHeight in build method: $expandedHeight");

    return CustomScrollView(
      slivers: [
        if (widget.expandedAppBar != null)
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: expandedHeight + widget.extraAppBarHeight,
            toolbarHeight: widget.toolBarHeight ?? kToolbarHeight,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                key: _flexibleChildKey,
                child: widget.expandedAppBar,
              ),
            ),
          ),
        if (widget.child != null)
          SliverList.list(
            children: [
              Padding(
                padding: widget.contentPadding ?? EdgeInsets.zero,
                child: widget.child,
              ),
            ],
          ),
        if (widget.itemBuilder != null && widget.itemCount > 0)
          SliverPadding(
            padding: widget.contentPadding ?? EdgeInsets.zero,
            sliver: SliverList.builder(
              itemCount: widget.itemCount,
              itemBuilder: widget.itemBuilder!,
            ),
          ),
      ],
    );
  }
}
