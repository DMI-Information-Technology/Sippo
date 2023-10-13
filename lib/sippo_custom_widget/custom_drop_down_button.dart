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
  });

  final String? initialValue;
  final bool setInitialValue;
  final Color? fillColor;
  final double? width;
  final double? height;
  final String? textHint;
  final List<T>? values;
  final List<String>? labelList;
  final void Function(T? value) onItemSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.width,
      height: height,
      child: DropdownButtonFormField2(
        value: setInitialValue ? initialValue ?? labelList?.first : null,
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          filled: true,
          fillColor: fillColor ?? Jobstopcolor.backgroudHome,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(context.fromWidth(CustomStyle.s)),
            borderSide: BorderSide.none,
          ),
        ),
        hint: Text(
          textHint ?? "",
          style: dmsregular.copyWith(fontSize: FontSize.title5(context)),
        ),
        onChanged: (value) {},
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
