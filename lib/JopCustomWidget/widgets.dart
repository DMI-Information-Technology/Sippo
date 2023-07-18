import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';

import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/jopstop_customstyle.dart';

class CustomAlertDialog extends StatefulWidget {
  final String imageAsset;
  final String title;
  final String description;
  final VoidCallback onConfirm;
  final Color? confirmBtnColor;

  const CustomAlertDialog({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.description,
    required this.onConfirm,
    this.confirmBtnColor,
  });

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  dynamic size = 0.0;
  double height = 0.00;
  double width = 0.00;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return AlertDialog(
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(64.0)),
      contentPadding: const EdgeInsets.all(32.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(widget.imageAsset),
          SizedBox(height: height / 32),
          Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35.0,
              color: Jobstopcolor.primarycolor,
            ),
          ),
          SizedBox(height: height / 64),
          Text(
            widget.description,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.onConfirm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.confirmBtnColor,
            ),
            child: const Text(
              'Confirm',
              style: TextStyle(color: Jobstopcolor.white),
            ),
          ),
        ),
      ],
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.hintText = "",
  });

  final Widget? icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style:
          dmsregular.copyWith(fontSize: 12, color: Jobstopcolor.primarycolor),
      cursorColor: Jobstopcolor.grey,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: hintText,
        hintStyle: dmsregular.copyWith(fontSize: 13, color: Jobstopcolor.grey),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: enabledUnderLineBorder,
        focusedBorder: focusedUnderLineBorder,
        errorBorder: errorUnderLineBorder,
      ),
      keyboardType: keyboardType,
    );
  }
}

class PasswordInputField extends StatefulWidget {
  const PasswordInputField({
    super.key,
    required this.controller,
    this.icon,
    this.hintText = "",
  });

  final Widget? icon;
  final TextEditingController controller;
  final String hintText;

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscureText = true;

  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: dmsregular.copyWith(
        fontSize: 12,
        color: Jobstopcolor.primarycolor,
      ),
      cursorColor: Jobstopcolor.grey,
      decoration: InputDecoration(
        prefixIcon: widget.icon,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: _togglePasswordStatus,
          color: Jobstopcolor.primarycolor,
        ),
        hintText: widget.hintText,
        hintStyle: dmsregular.copyWith(fontSize: 13, color: Jobstopcolor.grey),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: enabledUnderLineBorder,
        focusedBorder: focusedUnderLineBorder,
        errorBorder: errorUnderLineBorder,
      ),
      obscureText: _obscureText,
    );
  }
}

class CustomButtonAuth extends StatelessWidget {
  const CustomButtonAuth({
    super.key,
    required this.onTappeed,
    this.text = "",
    this.textColor = Jobstopcolor.white,
    this.backgroundColor = Jobstopcolor.primarycolor,
    this.borderColor,
    this.leadingIcon = const SizedBox(),
  });

  final Widget leadingIcon;
  final VoidCallback onTappeed;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return InkWell(
      highlightColor: Jobstopcolor.transparent,
      splashColor: Jobstopcolor.transparent,
      onTap: () {
        onTappeed();
      },
      child: Center(
        child: Container(
          height: height / 15,
          width: width / 1.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: backgroundColor,
            border: borderColor != null
                ? Border.all(width: 1, color: borderColor ?? Jobstopcolor.white)
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leadingIcon,
              SizedBox(
                width: width / 46,
              ),
              Text(
                text,
                style: dmsbold.copyWith(fontSize: 14, color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SeparatorLine extends StatelessWidget {
  const SeparatorLine({super.key, required this.text, this.dividerWidth = 20});

  final String? text;
  final double dividerWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: 1,
            width: double.infinity,
            child: Container(
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(text ?? 'or'.tr),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 1,
            width: double.infinity,
            child: Container(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
