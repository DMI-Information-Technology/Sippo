import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';

enum Gender {
  Male,
  Female,
}

class GenderPickerDialog extends StatelessWidget {
  void _onGenderSelected(BuildContext context, Gender gender) {
    Navigator.of(context).pop(gender);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return AlertDialog(
      title: Text('Select Gender'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Male'),
            onTap: () => _onGenderSelected(context, Gender.Male),
            leading: Image.asset(
              JobstopPngImg.maleIcon,
              height: height / 36,
              width: height / 38,
              color: Colors.blue,
              colorBlendMode: BlendMode.srcIn,
            ),
          ),
          ListTile(
            title: Text('Female'),
            onTap: () => _onGenderSelected(context, Gender.Female),
            leading: Image.asset(
              JobstopPngImg.femaleIcon,
              height: height / 34,
              width: height / 34,
              color: Colors.pinkAccent,
              colorBlendMode: BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}
