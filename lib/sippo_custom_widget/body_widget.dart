import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    super.key,
    this.child,
    this.bottomScreen,
    this.paddingContent,
    this.paddingBottom,
    this.topScreen,
    this.paddingTop,
    this.isScrollable = false,
    this.isTopScrollable = false,
  });

  final Widget? topScreen;
  final Widget? child;
  final Widget? bottomScreen;
  final EdgeInsets? paddingTop;
  final EdgeInsets? paddingContent;
  final EdgeInsets? paddingBottom;
  final bool isScrollable;
  final bool isTopScrollable;

  @override
  Widget build(BuildContext context) {
    return child != null || bottomScreen != null
        ? Column(
            children: [
              if (topScreen != null && !isTopScrollable)
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: paddingTop ?? EdgeInsets.zero,
                    child: topScreen!,
                  ),
                ),
              if (child != null)
                Expanded(
                  child: isScrollable
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              if (topScreen != null && isTopScrollable)
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: paddingTop ?? EdgeInsets.zero,
                                    child: topScreen!,
                                  ),
                                ),
                              Padding(
                                padding: paddingContent ?? EdgeInsets.zero,
                                child: child,
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: paddingContent ?? EdgeInsets.zero,
                          child: child,
                        ),
                ),
              if (bottomScreen != null)
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Padding(
                    padding: paddingBottom ?? EdgeInsets.zero,
                    child: bottomScreen,
                  ),
                )
            ],
          )
        : const Center(
            child: Text("No widgets."),
          );
  }
}
