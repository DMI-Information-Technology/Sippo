import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingInputField extends StatelessWidget {
  const LoadingInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.height / 36),
      child: SizedBox(
        height: context.height / 36,
        width: context.height / 36,
        child: const CircularProgressIndicator(
          strokeWidth: 1.5,
        ),
      ),
    );
  }
}
