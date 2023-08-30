import 'package:flutter/material.dart';
import 'package:jobspot/sippo_custom_widget/error_messages_dialog_snackbar/network_connnection_lost_widget.dart';

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
    this.isConnectionLost = false,
  });

  final bool isConnectionLost;
  final Widget? topScreen;
  final Widget? child;
  final Widget? bottomScreen;
  final EdgeInsets? paddingTop;
  final EdgeInsets? paddingContent;
  final EdgeInsets? paddingBottom;
  final bool isScrollable;
  final bool isTopScrollable;
  static const connLostWidget = const Positioned(
    top: 0,
    child: SafeArea(
      child: NetworkStatusNonWidget(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    print("internet not connected: $isConnectionLost");
    return _isHaveContent()
        ? Stack(
            children: [
              Column(
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
              ),
              if (isConnectionLost) connLostWidget
            ],
          )
        : const Center(
            child: Text("No widgets."),
          );
  }

  bool _isHaveContent() =>
      child != null || bottomScreen != null || topScreen != null;
}
