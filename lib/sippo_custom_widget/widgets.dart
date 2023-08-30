import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';

import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/sippo_customstyle.dart';
import '../JobGlobalclass/sippo_customstyle.dart' as customStyles;

class CustomAlertDialog extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String? description;
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
    this.description,
    this.confirmBtnTitle = "ok",
    this.confirmBtnColor = Jobstopcolor.primarycolor,
    this.onConfirm,
    this.cancelBtnTitle = "cancel",
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
      contentPadding: EdgeInsets.all(height / 42),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imageAsset, height: height / 4),
          SizedBox(height: height / 42),
          AutoSizeText(
            title,
            style: dmsbold.copyWith(
              fontSize: FontSize.title2(context),
              color: Jobstopcolor.primarycolor,
            ),
            textAlign: TextAlign.center,
          ),
          if (description != null)
            Column(
              children: [
                SizedBox(height: height / 64),
                AutoSizeText(
                  description ?? "",
                  style: dmsregular.copyWith(
                    color: Jobstopcolor.textColor,
                    fontSize: FontSize.paragraph2(
                      context,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
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
              shape: customStyles.circularBorderedShapeButton(height / 32),
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
              shape: customStyles.circularBorderedShapeButton(height / 32),
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
    this.controller,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.suffixIcon,
    this.hintText = "",
    this.initialValue,
    this.onChangedText,
    this.onSubmitted,
    this.validator,
  });

  final Widget? suffixIcon;
  final Widget? icon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String hintText;
  final String? initialValue;
  final void Function(String value)? onChangedText;
  final void Function(String value)? onSubmitted;
  final String? Function(String? value)? validator;

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
      initialValue: initialValue,
      decoration: InputDecoration(
        prefixIcon: icon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: dmsregular.copyWith(
          fontSize: height / 59,
          color: Jobstopcolor.grey,
        ),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: enabledUnderLineBorder,
        focusedBorder: focusedUnderLineBorder,
        errorBorder: errorUnderLineBorder,
      ),
      keyboardType: keyboardType,
      onChanged: onChangedText,
      onFieldSubmitted: onSubmitted,
      validator: validator,
    );
  }
}

class PasswordInputField extends StatefulWidget {
  const PasswordInputField({
    super.key,
    this.controller,
    this.icon,
    this.hintText = "",
    this.suffixIconColor,
    this.validator,
    this.onChangedText,
  });

  final Color? suffixIconColor;
  final Widget? icon;
  final TextEditingController? controller;
  final String hintText;
  final void Function(String)? onChangedText;
  final String? Function(String?)? validator;

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
      onChanged: widget.onChangedText,
      validator: widget.validator,
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

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    this.height,
    this.width,
    this.borderRadius = 0,
    required this.onTap,
    this.backgroundColor = Jobstopcolor.greyyy,
    this.paddingValue,
    this.margin,
    required this.child,
  });

  final EdgeInsets? margin;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final double borderRadius;
  final Widget child;
  final Color? backgroundColor;
  final double? paddingValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        height: height,
        width: width,
        padding:
            paddingValue != null ? EdgeInsets.all(paddingValue ?? 0.0) : null,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor,
        ),
        child: child,
      ),
    );
  }
}

class InputBorderedField extends StatelessWidget {
  const InputBorderedField({
    super.key,
    this.height,
    this.width,
    this.hintText,
    this.hintStyle,
    this.keyboardType,
    this.maxLine,
    this.fontSize,
    this.onTap,
    this.onTextChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.controller,
    this.initialValue,
    this.validator,
  });

  final String? Function(String? value)? validator;

  final String? initialValue;
  final String? hintText;
  final TextStyle? hintStyle;
  final double? height;
  final double? width;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLine;
  final double? fontSize;
  final bool readOnly;
  final VoidCallback? onTap;
  final void Function(String value)? onTextChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: Jobstopcolor.white,
      ),
      child: TextFormField(
        initialValue: initialValue,
        readOnly: readOnly,
        controller: controller,
        style: dmsregular.copyWith(fontSize: fontSize, color: Colors.black87),
        cursorColor: Jobstopcolor.grey,
        decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          hintStyle: hintStyle ??
              dmsregular.copyWith(
                fontSize: FontSize.title6(context),
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          fillColor: Jobstopcolor.white,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        keyboardType: keyboardType,
        maxLines: maxLine,
        onTap: onTap,
        onChanged: onTextChanged,
        validator: validator,
      ),
    );
  }
}
