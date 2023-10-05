import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/company_profile_controller/company_edit_add_job_controller.dart';
import 'package:jobspot/JopController/sippo_search_controller/user_filter_search.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/title_label_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

class SippoSearchJobsFilter extends StatefulWidget {
  const SippoSearchJobsFilter({Key? key}) : super(key: key);

  @override
  State<SippoSearchJobsFilter> createState() => _SippoSearchJobsFilterState();
}

class _SippoSearchJobsFilterState extends State<SippoSearchJobsFilter> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  final _controller = UserFilterSearchController.instance;

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
            TitleLabelWidget(
              "Category".tr,
              fontSize: FontSize.title4(context),
            ),
            InputBorderedField(
              readOnly: true,
              onTap: () => Get.back(),
              initialValue: _controller.filterSearchState.specialization.name,
            ),
            SizedBox(height: height / 36),
            TitleLabelWidget(
              "experienceLevels".tr,
              fontSize: FontSize.title4(context),
            ),
            _buildExperienceLevelsWrap(context),
            SizedBox(height: height / 36),
            TitleLabelWidget(
              "employmentType".tr,
              fontSize: FontSize.title4(context),
            ),
            _buildWorkPLaceTypeWrap(context),
            SizedBox(height: height / 36),
            const Divider(color: Jobstopcolor.grey),
            SizedBox(height: height / 64),
            TitleLabelWidget(
              "Salary".tr,
              fontSize: FontSize.title4(context),
            ),
            SizedBox(height: height / 36),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    _buildSalaryLabelText(context, "Minimum_Salary".tr),
                    Obx(() => _buildSalaryLabelText(
                          context,
                          _controller.filterSearchState.startSalary,
                        )),
                  ],
                ),
                Column(
                  children: [
                    _buildSalaryLabelText(context, "Maximum_Salary".tr),
                    Obx(() => _buildSalaryLabelText(
                          context,
                          _controller.filterSearchState.endSalary,
                        )),
                  ],
                ),
              ],
            ),
            SizedBox(height: height / 64),
            _buildRangeSalarySlider(context),
          ],
        ),
        paddingBottom: EdgeInsets.all(
          context.fromWidth(CustomStyle.paddingValue),
        ),
        bottomScreen: CustomButton(
          onTapped: () async {
            await _controller.onApplyFilterSubmitted();
            Get.until(
                (_) => Get.currentRoute == SippoRoutes.sippoUserJobSearch);
          },
          text: "Apply now",
        ),
      ),
    );
  }

  Obx _buildExperienceLevelsWrap(BuildContext context) {
    return Obx(() {
      final data = _controller.filterSearchState.experienceLevelList;
      return SizedBox(
        width: context.width,
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: context.width / 32,
          runAlignment: WrapAlignment.start,
          children: List.generate(
            data.length,
            (index) {
              return InkWell(
                onTap: () {
                  _controller.filterSearchState.experienceLevel = data[index];
                },
                child: Obx(() {
                  final experienceLvl =
                      _controller.filterSearchState.experienceLevel;
                  return Chip(
                    label: Text(
                      data[index].label ?? "",
                      style: TextStyle(
                        color:
                            experienceLvl == data[index] ? Colors.white : null,
                      ),
                    ),
                    backgroundColor: experienceLvl == data[index]
                        ? Jobstopcolor.primarycolor
                        : null,
                  );
                }),
              );
            },
          ),
        ),
      );
    });
  }

  Obx _buildWorkPLaceTypeWrap(BuildContext context) {
    return Obx(() {
      final data = _controller.filterSearchState.workPLaceTypeList;
      return SizedBox(
        width: context.width,
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: context.width / 32,
          runAlignment: WrapAlignment.start,
          children: List.generate(
            data.length,
            (i) {
              return InkWell(
                onTap: () {
                  _controller.filterSearchState.workPlaceType = data[i];
                },
                child: Obx(() {
                  final employmentType =
                      _controller.filterSearchState.workPlaceType;
                  return Chip(
                    label: Text(
                      data[i].title,
                      style: TextStyle(
                        color: employmentType == data[i] ? Colors.white : null,
                      ),
                    ),
                    backgroundColor: employmentType == data[i]
                        ? Jobstopcolor.primarycolor
                        : null,
                  );
                }),
              );
            },
          ),
        ),
      );
    });
  }

  Widget _buildRangeSalarySlider(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return RangeSlider(
            values: _controller.filterSearchState.rangeSalary,
            max: CompanyEditAddJobState.MAX_SALARY_RANGE,
            min: CompanyEditAddJobState.MIN_SALARY_RANGE,
            divisions: CompanyEditAddJobState.DIVISION,
            activeColor: Jobstopcolor.primarycolor,
            labels: RangeLabels(
              _controller.filterSearchState.rangeSalary.start
                  .roundToDouble()
                  .toString(),
              _controller.filterSearchState.rangeSalary.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              _controller.filterSearchState.rangeSalary = values;
            },
          );
        }),
        SizedBox(height: height / 64),
        Text(
          'The accepted range salary start '
          'from ${CompanyEditAddJobState.MAX_SALARY_RANGE} '
          'to ${CompanyEditAddJobState.MAX_SALARY_RANGE}',
          textAlign: TextAlign.start,
          style: dmsregular.copyWith(
            fontSize: FontSize.title6(context),
            color: Jobstopcolor.secondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSalaryLabelText(BuildContext context, String text) {
    return Text(
      text,
      style: dmsregular.copyWith(fontSize: FontSize.title5(context)),
    );
  }
}
