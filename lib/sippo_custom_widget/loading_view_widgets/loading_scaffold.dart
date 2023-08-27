import 'package:flutter/material.dart';

import 'overly_loading.dart';

class LoadingOverlayController with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  void unFocusTextField(BuildContext context) {
    if (_loading) FocusScope.of(context).unfocus();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    print("LoadingOverlayController is disposed.");
    super.dispose();
  }
}

class LoadingScaffold extends StatelessWidget {
  const LoadingScaffold({
    super.key,
    this.controller,
    this.appBar,
    this.body,
    this.backgroundColor,
  });

  final AppBar? appBar;
  final Widget? body;
  final Color? backgroundColor;
  final LoadingOverlayController? controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Scaffold(
          appBar: appBar,
          body: body,
          backgroundColor: backgroundColor,
        ),
        if (controller != null)
          ListenableBuilder(
            listenable: controller!,
            builder: (context, child) {
              controller?.unFocusTextField(context);
              return _buildLoadingWidget(controller?.loading ?? false);
            },
          ),
      ],
    );
  }

  Widget _buildLoadingWidget(bool show) => show
      ? GestureDetector(
        onTap: () => controller?.loading = false,
        child: const LoadingOverlay(),
      )
      : const SizedBox.shrink();
}
