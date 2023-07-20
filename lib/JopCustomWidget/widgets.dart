import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';

import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/jopstop_customstyle.dart';

class CustomAlertDialog extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String description;
  final String? confirmBtnTitle;
  final Color? confirmBtnColor;
  final VoidCallback? onConfirm;
  final String? cancelBtnTitle;
  final Color? cancelBtnColor;
  final VoidCallback? onCancel;

  const CustomAlertDialog({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.description,
    this.confirmBtnTitle,
    this.confirmBtnColor = Jobstopcolor.primarycolor,
    this.onConfirm,
    this.cancelBtnTitle,
    this.cancelBtnColor = Jobstopcolor.primarycolor,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    // double width = size.width;
    return AlertDialog(
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(64.0)),
      contentPadding: const EdgeInsets.all(32.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imageAsset),
          SizedBox(height: height / 32),
          Text(
            title,
            style: dmsbold.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: height / 36.0,
              color: Jobstopcolor.primarycolor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height / 64),
          Text(
            description,
            style: dmsregular.copyWith(
              color: Jobstopcolor.textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        if (onConfirm != null)
          ElevatedButton(
            onPressed: () {
              if (onConfirm != null) onConfirm!();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmBtnColor,
            ),
            child: Text(
              confirmBtnTitle ?? "",
              style: dmsregular.copyWith(color: Jobstopcolor.white),
            ),
          ),
        if (onCancel != null)
          ElevatedButton(
            onPressed: () {
              onCancel!();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmBtnColor,
            ),
            child: Text(
              cancelBtnTitle ?? "",
              style: dmsregular.copyWith(color: Jobstopcolor.white),
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
    this.onChangedCallback,
    this.validatorCallback,
  });

  final Widget? icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final void Function(String)? onChangedCallback;
  final String? Function(String?)? validatorCallback;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    // double width = size.width;
    return TextFormField(
      controller: controller,
      style: dmsregular.copyWith(
          fontSize: height / 59, color: Jobstopcolor.primarycolor),
      cursorColor: Jobstopcolor.grey,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: hintText,
        hintStyle: dmsregular.copyWith(
            fontSize: height / 59, color: Jobstopcolor.grey),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: enabledUnderLineBorder,
        focusedBorder: focusedUnderLineBorder,
        errorBorder: errorUnderLineBorder,
      ),
      keyboardType: keyboardType,
      onChanged: onChangedCallback,
      validator: validatorCallback,
    );
  }
}

class PasswordInputField extends StatefulWidget {
  const PasswordInputField({
    super.key,
    required this.controller,
    this.icon,
    this.hintText = "",
    this.suffixIconColor,
    this.onChangedCallback,
    this.validatorCallback,
  });

  final Color? suffixIconColor;
  final Widget? icon;
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChangedCallback;
  final String? Function(String?)? validatorCallback;

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
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return TextFormField(
      controller: widget.controller,
      style: dmsregular.copyWith(
        fontSize: height / 59,
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
          color: widget.suffixIconColor != null
              ? widget.suffixIconColor ?? Jobstopcolor.primarycolor
              : null,
        ),
        hintText: widget.hintText,
        hintStyle: dmsregular.copyWith(
            fontSize: height / 59, color: Jobstopcolor.grey),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: enabledUnderLineBorder,
        focusedBorder: focusedUnderLineBorder,
        errorBorder: errorUnderLineBorder,
      ),
      obscureText: _obscureText,
      onChanged: widget.onChangedCallback,
      validator: widget.validatorCallback,
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
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
          width: width / 1.1,
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
        Text(
          text ?? 'or'.tr,
          style: dmsregular.copyWith(color: Jobstopcolor.textColor),
        ),
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

class PhoneResetPasswordCard extends StatelessWidget {
  final String phoneNumber;
  final Color? borderColor;
  final String description;

  const PhoneResetPasswordCard(
      {super.key,
      required this.phoneNumber,
      this.borderColor,
      this.description = ""});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(50),
        border: borderColor != null
            ? Border.all(
                color: borderColor ?? Colors.transparent,
              )
            : null,
      ),
      child: ListTile(
        leading: Container(
          width: height / 15,
          height: height / 15,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Jobstopcolor.lightsecondary,
          ),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.message,
              color: Jobstopcolor.primarycolor,
              size: height / 25,
            ),
          ),
        ),
        title: Text(
          phoneNumber,
          style: dmsbold.copyWith(
            fontSize: height / 59,
          ),
        ),
        subtitle: Text(
          description,
          style: dmsbold.copyWith(
              fontSize: height / 72, color: Jobstopcolor.textColor),
        ),
      ),
    );
  }
}
