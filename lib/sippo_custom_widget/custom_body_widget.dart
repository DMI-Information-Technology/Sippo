import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';

class CustomBodyWidget extends StatefulWidget {
  const CustomBodyWidget({
    super.key,
    required this.expandedAppBarHeight,
    this.toolBarHeight,
    this.expandedAppBar,
    this.contentPadding,
    this.child,
    this.extraAppBarHeight = 0.0,
    this.automaticallyImplyLeading = false,
    this.leading,
    this.actions,
  })  : this.children = const [],
        this.itemCount = 0,
        this.itemBuilder = null,
        this.separatedBuilder = null;

  const CustomBodyWidget.children({
    super.key,
    required this.expandedAppBarHeight,
    this.toolBarHeight,
    this.expandedAppBar,
    this.children = const [],
    this.extraAppBarHeight = 0.0,
    this.automaticallyImplyLeading = false,
    this.leading,
    this.actions,
  })  : this.contentPadding = null,
        this.itemCount = 0,
        this.itemBuilder = null,
        this.separatedBuilder = null,
        this.child = null;

  CustomBodyWidget.itemBuilder({
    super.key,
    required this.expandedAppBarHeight,
    this.toolBarHeight,
    this.expandedAppBar,
    this.contentPadding,
    this.extraAppBarHeight = 0.0,
    this.itemCount = 0,
    this.itemBuilder,
    this.automaticallyImplyLeading = false,
    this.leading,
    this.separatedBuilder,
    this.actions,
  })  : this.child = null,
        this.children = const [];

  final bool automaticallyImplyLeading;
  final int itemCount;
  final double extraAppBarHeight;
  final double expandedAppBarHeight;
  final double? toolBarHeight;
  final Widget? expandedAppBar;
  final EdgeInsets? contentPadding;
  final Widget? child;
  final List<Widget> children;
  final Widget? Function(BuildContext context, int index)? itemBuilder;
  final Widget? Function(BuildContext context, int index)? separatedBuilder;
  final Widget? leading;
  final List<Widget>? actions;

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

  Widget? _inLeading() {
    return widget.automaticallyImplyLeading && widget.leading == null
        ? InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          )
        : widget.leading;
  }

  double _expandedAppBarHeight() {
    return expandedHeight +
        widget.extraAppBarHeight +
        (widget.automaticallyImplyLeading && widget.leading == null ||
                widget.leading != null
            ? kToolbarHeight
            : 0);
  }

  Widget? _buildSelectedWidget(BuildContext context) {
    if (widget.child != null) {
      return SliverPadding(
        padding: widget.contentPadding ?? EdgeInsets.zero,
        sliver: SliverToBoxAdapter(child: widget.child),
      );
    } else if (widget.itemBuilder != null && widget.itemCount > 0) {
      return SliverPadding(
        padding: widget.contentPadding ?? EdgeInsets.zero,
        sliver: SliverList.separated(
          separatorBuilder: (context, _) => SizedBox(
            height: context.fromHeight(CustomStyle.spaceBetween),
          ),
          itemCount: widget.itemCount,
          itemBuilder: widget.itemBuilder!,
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final myWidget = _buildSelectedWidget(context);
    return CustomScrollView(
      slivers: [
        if (widget.expandedAppBar != null)
          SliverAppBar(
            automaticallyImplyLeading: widget.automaticallyImplyLeading,
            leading: _inLeading(),
            actions: widget.actions,
            expandedHeight: _expandedAppBarHeight(),
            // toolbarHeight: widget.toolBarHeight ?? kToolbarHeight,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox(
                key: _flexibleChildKey,
                child: widget.expandedAppBar,
              ),
            ),
          ),
        if (myWidget != null) myWidget else ...widget.children,
      ],
    );
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
}
