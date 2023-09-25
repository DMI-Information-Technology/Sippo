import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/utils/validating_input.dart';

class JobAboutme extends StatefulWidget {
  const JobAboutme({Key? key}) : super(key: key);

  @override
  State<JobAboutme> createState() => _JobAboutmeState();
}

class _JobAboutmeState extends State<JobAboutme> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  TextEditingController aboutme = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: BodyWidget(
          isScrollable: true,
          paddingContent: EdgeInsets.symmetric(
            horizontal: width / CustomStyle.paddingValue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About me",
                style: dmsbold.copyWith(
                  fontSize: 16,
                  color: Jobstopcolor.primarycolor,
                ),
              ),
              SizedBox(height: height / CustomStyle.verticalSpaceBetween),
              InputBorderedField(
                controller: aboutme,
                hintText: 'tell me about you',
                hintStyle: dmsregular.copyWith(
                  fontSize: FontSize.label(context),
                ),
                maxLine: 5,
                height: height / 4,
                validator: (value) {
                  if (!ValidatingInput.validateWords(value ?? "")) {
                    return "the word must be just contains letter.";
                  }
                  return null;
                },
              ),
            ],
          ),
          paddingBottom: EdgeInsets.all(
            width / CustomStyle.paddingBottomButton,
          ),
          bottomScreen: CustomButton(
            onTapped: () {
              if (_formKey.currentState == null) return;
              if (_formKey.currentState!.validate()) {}
            },
            text: "Save",
          ),
        ),
      ),
    );
  }
}
