import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3), // Low-opacity black overlay
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
