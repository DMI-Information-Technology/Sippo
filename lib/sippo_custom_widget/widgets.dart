import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/custom_app_controller/switch_status_controller.dart';
import 'package:sippo/utils/getx_text_editing_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/jobstopimges.dart';
import '../JobGlobalclass/sippo_customstyle.dart' as customStyles;
import '../JobGlobalclass/sippo_customstyle.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? imageAsset;
  final String title;
  final bool? isLottie;
  final String? description;
  final String? confirmBtnTitle;
  final Color? confirmBtnColor;
  final VoidCallback? onConfirm;
  final String? cancelBtnTitle;
  final Color? cancelBtnColor;
  final VoidCallback? onCancel;
  final bool _vertical;
  final Color? titleColor;

  const CustomAlertDialog({
    super.key,
    this.imageAsset,
    required this.title,
    this.description,
    this.confirmBtnTitle,
    this.confirmBtnColor = SippoColor.primarycolor,
    this.onConfirm,
    this.cancelBtnTitle,
    this.cancelBtnColor = SippoColor.lightprimary,
    this.onCancel,
    this.titleColor,
    this.isLottie = false,
  }) : _vertical = false;

  const CustomAlertDialog.verticalButtons({
    super.key,
    this.imageAsset,
    required this.title,
    this.description,
    this.confirmBtnTitle,
    this.confirmBtnColor = SippoColor.primarycolor,
    this.onConfirm,
    this.cancelBtnTitle,
    this.cancelBtnColor = SippoColor.lightprimary,
    this.onCancel,
    this.titleColor,
    this.isLottie = false,
  }) : _vertical = true;

  Widget _buildButtonsLayout(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double height = size.height;

    return switch (_vertical) {
      // TODO: Handle this case.
      true => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (onConfirm != null)
              CustomButton(
                fitHeight: true,
                onTapped: () {
                  onConfirm?.call();
                },
                text: confirmBtnTitle ?? 'ok'.tr,
                textColor: Colors.white,
                backgroundColor: confirmBtnColor,
              ),
            if (onCancel != null)
              CustomButton(
                textPadding: EdgeInsets.zero,
                fitHeight: true,
                onTapped: () {
                  onCancel?.call();
                },
                text: cancelBtnTitle ?? 'cancel'.tr,
                textColor: confirmBtnColor,
                backgroundColor: cancelBtnColor,
              ),
          ],
        ),
      false => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (onConfirm != null) ...[
              ElevatedButton(
                onPressed: () {
                  onConfirm?.call();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: confirmBtnColor,
                  shape: customStyles.circularBorderedShapeButton(height / 64),
                ),
                child: Text(
                  confirmBtnTitle ?? 'ok'.tr,
                  style: dmsregular.copyWith(color: Colors.white),
                ),
              ),
              SizedBox(width: context.fromWidth(CustomStyle.spaceBetween)),
            ],
            if (onCancel != null)
              ElevatedButton(
                onPressed: () {
                  onCancel?.call();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: cancelBtnColor,
                  shape: customStyles.circularBorderedShapeButton(height / 64),
                ),
                child: Text(
                  cancelBtnTitle ?? 'cancel'.tr,
                  style: dmsregular.copyWith(
                    color: SippoColor.primarycolor,
                  ),
                ),
              ),
          ],
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    // double width = size.width;
    return Dialog(
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(height / 32)),
      // insetPadding: EdgeInsets.symmetric(horizontal: height /32),
      child: Padding(
        padding: EdgeInsets.all(context.fromWidth(CustomStyle.paddingValue)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageAsset != null)
              Padding(
                padding: EdgeInsets.all(context.fromHeight(
                  CustomStyle.paddingValue,
                )),
                child: (isLottie != null && isLottie!)
                    ? Lottie.asset(imageAsset!,
                        height: height / 5,
                        frameRate: FrameRate.max,
                        fit: BoxFit.contain)
                    : Image.asset(imageAsset!, height: height / 5),
              ),
            AutoSizeText(
              title,
              style: dmsbold.copyWith(
                fontSize: FontSize.title3(context),
                color: titleColor ?? SippoColor.primarycolor,
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
                      color: SippoColor.textColor,
                      fontSize: FontSize.paragraph2(
                        context,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            SizedBox(height: height / 64),
            _buildButtonsLayout(context),
          ],
        ),
      ),
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
    this.maxLength,
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
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlignVertical: TextAlignVertical.bottom,
      style: dmsregular.copyWith(
        fontSize: context.height / 59,
        color: SippoColor.primarycolor,
      ),
      cursorColor: SippoColor.grey,
      maxLines: 1,
      initialValue: initialValue,
      decoration: InputDecoration(
        counterText: "",
        prefixIcon: icon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: dmsregular.copyWith(
          fontSize: context.height / 59,
          color: SippoColor.grey,
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
      maxLength: maxLength ?? 40,
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
      textAlignVertical: TextAlignVertical.bottom,
      style: dmsregular.copyWith(
        fontSize: height / 59,
        color: SippoColor.primarycolor,
      ),
      cursorColor: SippoColor.grey,
      decoration: InputDecoration(
        prefixIcon: widget.icon,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
          onPressed: _togglePasswordStatus,
          color: widget.suffixIconColor != null
              ? widget.suffixIconColor ?? SippoColor.primarycolor
              : null,
        ),
        hintText: widget.hintText,
        hintStyle:
            dmsregular.copyWith(fontSize: height / 59, color: SippoColor.grey),
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

class CustomButton2 extends StatelessWidget {
  const CustomButton2({
    super.key,
    required this.onTapped,
    required this.text,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.leadingIcon,
    this.fontSize,
  });

  final Widget? leadingIcon;
  final VoidCallback onTapped;
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return InkWell(
      highlightColor: SippoColor.transparent,
      splashColor: SippoColor.transparent,
      onTap: onTapped,
      child: Center(
        child: Container(
          height: height / 15,
          width: width / 1.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: backgroundColor ?? SippoColor.primarycolor,
            border: borderColor != null
                ? Border.all(width: 1, color: borderColor ?? SippoColor.white)
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leadingIcon != null) ...[
                leadingIcon ?? const SizedBox.shrink(),
                SizedBox(width: width / 46),
              ],
              Text(
                text,
                style: dmsbold.copyWith(
                  fontSize: fontSize ?? FontSize.title6(context),
                  color: textColor ?? SippoColor.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTapped,
    required this.text,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.leadingIcon,
    this.fontSize,
    this.elevation = 0,
    this.borderRadiusValue,
    this.fitHeight = false,
    this.textPadding = EdgeInsets.zero,
    this.maxLine,
  });

  final EdgeInsets textPadding;

  final double elevation;
  final Widget? leadingIcon;
  final VoidCallback? onTapped;
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? fontSize;
  final double? borderRadiusValue;
  final bool fitHeight;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: fitHeight ? null : context.height / 16,
      width: context.width / 1.1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue ?? 50),
            side: borderColor != null
                ? BorderSide(color: borderColor ?? Colors.transparent, width: 1)
                : BorderSide.none,
          ),
        ),
        onPressed: onTapped,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              leadingIcon ?? const SizedBox.shrink(),
              SizedBox(width: context.width / 46),
            ],
            Expanded(
              child: Padding(
                padding: textPadding,
                child: Text(
                  text,
                  style: dmsbold.copyWith(
                    fontSize: fontSize ?? FontSize.title6(context),
                    color: textColor ?? SippoColor.white,
                  ),
                  maxLines: maxLine,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
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
          style: dmsregular.copyWith(color: SippoColor.textColor),
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
            color: SippoColor.lightsecondary,
          ),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.message,
              color: SippoColor.primarycolor,
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
              fontSize: height / 72, color: SippoColor.textColor),
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
    this.onTap,
    this.backgroundColor = SippoColor.secondary,
    this.paddingValue,
    this.margin,
    required this.child,
    this.icon, // Added icon property
  });

  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final double borderRadius;
  final Widget child;
  final Color? backgroundColor;
  final double? paddingValue;
  final IconData? icon; // Icon to display

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column( // Use Column for vertical layout
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) // Conditionally show icon
            Container(
              padding:  EdgeInsets.all(8.0), // Adjust padding as needed
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Customize circle color
              ),
              child: Icon(
                icon,
                color: backgroundColor, // Customize icon color
              ),
            ),
          child, // Your existing text/content widget
        ],
      ),
    );
  }
}
class InputBorderedField extends StatelessWidget {
  const InputBorderedField(
      {super.key,
      this.height,
      this.width,
      this.hintText,
      this.hintStyle,
      this.keyboardType,
      this.maxLine = 1,
      this.fontSize,
      this.onTap,
      this.onTextChanged,
      this.suffixIcon,
      this.prefixIcon,
      this.readOnly = false,
      this.controller,
      this.initialValue,
      this.validator,
      this.textInputAction = TextInputAction.done,
      this.onFieldSubmitted,
      this.onTapOutside,
      this.borderRadiusValue,
      this.verticalPaddingValue,
      this.gController,
      this.fillColor,
      this.maxLength,
      this.focusNode,
      this.fontColor,
      this.prefixIconColor,
      this.showCounter = false, this.icon

      // this.isLoading = false,
      });

  final Color? fontColor;
  final double? verticalPaddingValue;
  final String? Function(String? value)? validator;
  final GetXTextEditingController? gController;
  final String? initialValue;
  final IconData? icon;
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
  final void Function(String value)? onFieldSubmitted;
  final void Function(PointerDownEvent event)? onTapOutside;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final double? borderRadiusValue;
  final Color? fillColor;
  final bool showCounter;
  final int? maxLength;
  final FocusNode? focusNode;
  final Color? prefixIconColor;

  // final bool isLoading;
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
        focusNode: focusNode,
        maxLength: maxLength,
        textInputAction: textInputAction,
        initialValue: initialValue,
        readOnly: readOnly,
        controller: gController?.controller ?? controller,
        style: dmsregular.copyWith(
            fontSize: fontSize, color: fontColor ?? Colors.black87),
        cursorColor: SippoColor.grey,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          counterStyle: TextStyle(height: 0.0),
          counterText: showCounter ? null : '',
          contentPadding: EdgeInsets.symmetric(
            vertical: verticalPaddingValue ?? 0.0,
            horizontal: context.fromWidth(CustomStyle.paddingValue),
          ),
          filled: true,
          hintText: hintText,
          hintStyle: hintStyle ??
              dmsregular.copyWith(
                fontSize: FontSize.label(context),
                color: Colors.grey,
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue ?? 15),
            borderSide: BorderSide.none,
          ),
          fillColor: fillColor ?? SippoColor.white,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          prefixIconColor: prefixIconColor,
        ),
        keyboardType: keyboardType,
        maxLines: maxLine,
        onTap: onTap,
        onChanged: onTextChanged,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        onTapOutside: onTapOutside,
      ),
    );
  }
}

class PasswordInputBorderedField extends StatefulWidget {
  const PasswordInputBorderedField({
    super.key,
    this.height,
    this.width,
    this.hintText,
    this.hintStyle,
    this.keyboardType,
    this.maxLine = 1,
    this.fontSize,
    this.onTap,
    this.onTextChanged,
    this.prefixIcon,
    this.readOnly = false,
    this.controller,
    this.initialValue,
    this.validator,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
    this.onTapOutside,
    this.borderRadiusValue,
    this.verticalPaddingValue,
    this.gController,
    this.fillColor,
    this.maxLength,
    this.focusNode,
    this.fontColor,
    this.prefixIconColor,

    // this.isLoading = false,
  });

  final Color? fontColor;
  final double? verticalPaddingValue;
  final String? Function(String? value)? validator;
  final GetXTextEditingController? gController;
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
  final void Function(String value)? onFieldSubmitted;
  final void Function(PointerDownEvent event)? onTapOutside;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final double? borderRadiusValue;
  final Color? fillColor;
  final int? maxLength;
  final FocusNode? focusNode;
  final Color? prefixIconColor;

  @override
  State<PasswordInputBorderedField> createState() =>
      _PasswordInputBorderedFieldState();
}

class _PasswordInputBorderedFieldState
    extends State<PasswordInputBorderedField> {
  final _obscureController = SwitchStatusController(status: true);

  // final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: _obscureController,
        builder: (context, _) {
          return Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // color: Jobstopcolor.white,
            ),
            child: TextFormField(
              focusNode: widget.focusNode,
              maxLength: widget.maxLength,
              textInputAction: widget.textInputAction,
              initialValue: widget.initialValue,
              readOnly: widget.readOnly,
              controller: widget.gController?.controller ?? widget.controller,
              style: dmsregular.copyWith(
                  fontSize: widget.fontSize,
                  color: widget.fontColor ?? Colors.black87),
              cursorColor: SippoColor.grey,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                counterStyle: TextStyle(height: 0.0),
                counterText: '',
                contentPadding: EdgeInsets.symmetric(
                  vertical: widget.verticalPaddingValue ?? 0.0,
                  horizontal: context.fromWidth(CustomStyle.paddingValue),
                ),
                filled: true,
                hintText: widget.hintText,
                hintStyle: widget.hintStyle ??
                    dmsregular.copyWith(
                      fontSize: FontSize.label(context),
                      color: Colors.grey,
                    ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadiusValue ?? 15),
                  borderSide: BorderSide.none,
                ),
                fillColor: widget.fillColor ?? SippoColor.white,
                suffixIcon: InkWell(
                  onTap: () {
                    _obscureController.status = !_obscureController.status;
                  },
                  child: Icon(
                    _obscureController.status == true
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                prefixIcon: widget.prefixIcon,
                prefixIconColor: widget.prefixIconColor,
              ),
              obscureText: _obscureController.status == true,
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLine,
              onTap: widget.onTap,
              onChanged: widget.onTextChanged,
              validator: widget.validator,
              onFieldSubmitted: widget.onFieldSubmitted,
              onTapOutside: widget.onTapOutside,
            ),
          );
        });
  }
}

class InputCloser extends StatelessWidget {
  const InputCloser({
    super.key,
    required this.child,
    required this.onCloseTap,
    this.inputDone = false,
    this.paddingHButtonValue,
    this.paddingVButtonValue,
  });

  final double? paddingHButtonValue;
  final double? paddingVButtonValue;
  final Widget child;
  final VoidCallback onCloseTap;
  final bool inputDone;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: child,
        ),
        InkWell(
          onTap: onCloseTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: paddingHButtonValue ??
                    context.fromWidth(
                      CustomStyle.xxxl,
                    ),
                vertical: paddingVButtonValue ?? 0.0),
            child: Icon(
              inputDone ? Icons.done_rounded : Icons.close_rounded,
              size: context.fromWidth(CustomStyle.xs),
            ),
          ),
        )
      ],
    );
  }
}

class FilterButtonWidget extends StatelessWidget {
  const FilterButtonWidget({
    super.key,
    this.color,
    this.onTap,
  });

  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: context.height / 18,
        width: context.height / 18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color ?? SippoColor.primarycolor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(JobstopPngImg.filter),
        ),
      ),
    );
  }
}

// extension ObxWidget on Widget {
//   Widget obx() {
//     return Obx(() => this);
//   }
// }

class CustomDialogRow extends StatelessWidget {
  final IconData iconData;
  final String text;
  final String url;

  const CustomDialogRow({
    required this.iconData,
    required this.text,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        try {
          launchUrl(Uri.parse(url));
        } catch (e, s) {
          print(e);
          print(s);
        }
      },
      child: ListTile(
        leading: FaIcon(
          iconData,
          color: SippoColor.primarycolor,
        ), // Use Image.network for online images
        title: Text(text), minVerticalPadding: 0.0,
      ),
    );
  }
}
