import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

enum Gender {
  Male,
  Female,
}

class GenderPickerDialog extends StatelessWidget {
  const GenderPickerDialog({
    super.key,
    this.genderValue,
    required this.onSelectedGender,
  });

  final void Function(Gender? value) onSelectedGender;
  final Gender? genderValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          context.width / 24,
        ),
      ),
      title: Text('Select Gender'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Male'),
            leading: Image.asset(
              JobstopPngImg.maleIcon,
              height: height / 36,
              width: height / 38,
              color: Colors.blue,
              colorBlendMode: BlendMode.srcIn,
            ),
            trailing: Radio(
              value: Gender.Male,
              groupValue: genderValue,
              onChanged: (value) => onSelectedGender(value),
            ),
          ),
          ListTile(
            title: Text('Female'),
            leading: Image.asset(
              JobstopPngImg.femaleIcon,
              height: height / 34,
              width: height / 34,
              color: Colors.pinkAccent,
              colorBlendMode: BlendMode.srcIn,
            ),
            trailing: Radio(
              value: Gender.Female,
              groupValue: genderValue,
              onChanged: (value) => onSelectedGender(value),
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        SizedBox(
          width: context.width / 4,
          height: context.height / 21,
          child: CustomButton(
            onTapped: () => Get.back(),
            text: "Done",
          ),
        )
      ],
    );
  }
}
