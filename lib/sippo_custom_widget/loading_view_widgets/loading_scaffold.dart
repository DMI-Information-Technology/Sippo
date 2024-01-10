import 'package:flutter/material.dart';
import 'package:sippo/custom_app_controller/switch_status_controller.dart';

import 'overly_loading.dart';

class LoadingScaffold extends StatelessWidget {
  const LoadingScaffold(
      {super.key,
      this.controller,
      this.appBar,
      this.body,
      this.backgroundColor,
      this.extendBodyBehindAppBar = false,
      this.canPopOnLoading = true,
      this.floatingActionButton,
      this.bottomNavigationBar});

  final FloatingActionButton? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Color? backgroundColor;
  final SwitchStatusController? controller;
  final bool extendBodyBehindAppBar;
  final bool canPopOnLoading;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!canPopOnLoading && controller?.status == true) return false;
        if (controller?.status == true) {
          controller?.pause();
          return false;
        }
        return true;
      },
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Scaffold(
            floatingActionButton: floatingActionButton,
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            appBar: appBar,
            body: body,
            backgroundColor: backgroundColor,
            bottomNavigationBar: bottomNavigationBar,
          ),
          if (controller != null)
            ListenableBuilder(
              listenable: controller!,
              builder: (context, child) {
                controller?.unFocusTextField(context);
                return _buildLoadingWidget(controller?.status ?? false);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget(bool show) =>
      show ? const LoadingOverlay() : const SizedBox.shrink();
}
