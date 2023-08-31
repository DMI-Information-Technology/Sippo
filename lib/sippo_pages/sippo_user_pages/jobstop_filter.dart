import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/title_label_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

class JobstopFilter extends StatefulWidget {
  const JobstopFilter({Key? key}) : super(key: key);

  @override
  State<JobstopFilter> createState() => _JobstopFilterState();
}

class _JobstopFilterState extends State<JobstopFilter> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Filter".tr,
          style: dmsbold.copyWith(fontSize: 20),
        ),
      ),
      body: BodyWidget(
        isScrollable: true,
        paddingContent: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.paddingValue),
          vertical: context.fromHeight(CustomStyle.paddingValue2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleLabelWidget("Category".tr),
            SizedBox(height: height / 46),
            InputBorderedField(
              borderRadiusValue: context.fromWidth(CustomStyle.m),
            ),
            SizedBox(height: height / 36),
            TitleLabelWidget("Sub_Category".tr),
            SizedBox(height: height / 46),
            InputBorderedField(
              borderRadiusValue: context.fromWidth(CustomStyle.m),
            ),
            SizedBox(height: height / 36),
            TitleLabelWidget("Location".tr),
            SizedBox(height: height / 46),
            InputBorderedField(
              borderRadiusValue: context.fromWidth(CustomStyle.m),
            ),
            SizedBox(height: height / 36),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSalaryLabelText(context, "Minimum_Salary".tr),
                _buildSalaryLabelText(context, "Maximum_Salary".tr),
              ],
            ),
            SizedBox(height: height / 46),
            TitleLabelWidget("Salary".tr),
            SizedBox(height: height / 46),
            RangeSlider(
              values: _currentRangeValues,
              max: 100,
              activeColor: Jobstopcolor.primarycolor,
              labels: RangeLabels(
                _currentRangeValues.start.roundToDouble().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
            const Divider(color: Jobstopcolor.grey),
            SizedBox(
              height: height / 46,
            ),
            Text(
              "Job_Type".tr,
              style: dmsbold.copyWith(fontSize: 14),
            ),
            SizedBox(height: height / 36),
            // chips
          ],
        ),
        paddingBottom: EdgeInsets.all(
          context.fromWidth(CustomStyle.paddingValue),
        ),
        bottomScreen: CustomButton(
          onTappeed: () {},
          text: "Apply now",
        ),
      ),
    );
  }

  Widget _buildSalaryLabelText(BuildContext context, String text) {
    return Text(
      text,
      style: dmsregular.copyWith(fontSize: FontSize.title5(context)),
    );
  }
}
