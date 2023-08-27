import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    super.key,
    this.child,
    this.bottomScreen,
    this.paddingContent,
    this.paddingBottom,
    this.isScrollable = false,
  });

  final Widget? child;
  final Widget? bottomScreen;
  final EdgeInsets? paddingContent;
  final EdgeInsets? paddingBottom;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return child != null || bottomScreen != null
        ? Column(
            children: [
              if (child != null)
                Expanded(
                  child: isScrollable
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: paddingContent ?? EdgeInsets.zero,
                            child: child,
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
