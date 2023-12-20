import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/sippo_customstyle.dart';
import '../JobGlobalclass/text_font_size.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    this.values,
    this.labelList,
    required this.onItemSelected,
    this.textHint,
    this.width,
    this.height,
    this.setInitialValue = false,
    this.initialValue,
    this.fillColor,
    this.underLineBorder = false,
    this.prefixIcon,
    this.hPaddingValue,
    this.hintTextColor,
    this.validator,
  });

  final bool underLineBorder;
  final String? initialValue;
  final bool setInitialValue;
  final Color? fillColor;
  final double? width;
  final double? height;
  final String? textHint;
  final List<T>? values;
  final List<String>? labelList;
  final void Function(T? value) onItemSelected;
  final Widget? prefixIcon;
  final double? hPaddingValue;
  final Color? hintTextColor;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.width,
      height: height,
      child: DropdownButtonFormField2(
        value: setInitialValue ? initialValue ?? labelList?.first : null,
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: hPaddingValue ?? 0.0,
          ),
          filled: true,
          fillColor: fillColor ?? SippoColor.backgroudHome,
          enabledBorder: underLineBorder
              ? UnderlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(context.fromWidth(CustomStyle.s)),
                  borderSide: BorderSide(
                    color: SippoColor.grey[400] ?? Colors.grey,
                    width: 3,
                  ),
                )
              : null,
          focusedBorder: underLineBorder
              ? UnderlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(context.fromWidth(CustomStyle.s)),
                  borderSide: BorderSide(
                    color: SippoColor.primarycolor,
                    width: 3,
                  ),
                )
              : null,
          errorBorder: underLineBorder
              ? UnderlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(context.fromWidth(CustomStyle.s)),
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 3,
                  ),
                )
              : null,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(context.fromWidth(CustomStyle.s)),
            borderSide: underLineBorder ? const BorderSide() : BorderSide.none,
          ),
        ),
        validator: validator,
        hint: Text(
          textHint ?? "",
          style: dmsmedium.copyWith(
            //fontSize: FontSize.paragraph(context),
            color: hintTextColor,
          ),
        ),
        onChanged: (value) {
          print('CustomDropdownButton.build');
        },
        items: List.generate(labelList?.length ?? 0, (index) {
          return DropdownMenuItem(
            value: labelList?[index],
            child: Text(labelList?[index] ?? ''),
            onTap: () => onItemSelected(values?[index]),
          );
        }),
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.only(right: 8),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black45,
          ),
          iconSize: 24,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              context.fromWidth(CustomStyle.s),
            ),
          ),
        ),
      ),
    );
  }
}
