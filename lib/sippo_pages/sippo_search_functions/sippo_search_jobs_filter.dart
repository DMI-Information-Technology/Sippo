import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/company_profile_controller/company_edit_add_job_controller.dart';
import 'package:sippo/sippo_controller/sippo_search_controller/user_filter_search.dart';
import 'package:sippo/sippo_custom_widget/body_widget.dart';
import 'package:sippo/sippo_custom_widget/custom_drop_down_button.dart';
import 'package:sippo/sippo_custom_widget/title_label_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_pages/sippo_message_pages/min_max_salary_message_text_wiedgt.dart';

class SippoSearchJobsFilter extends StatefulWidget {
  const SippoSearchJobsFilter({Key? key}) : super(key: key);

  @override
  State<SippoSearchJobsFilter> createState() => _SippoSearchJobsFilterState();
}

class _SippoSearchJobsFilterState extends State<SippoSearchJobsFilter> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  final _controller = SippoFilterSearchController.instance;

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
              controller:
                  _controller.filterSearchState.specializationsSearchController,
              readOnly: true,
              onTap: () => Get.toNamed(
                SippoRoutes.filterSpecializationsJobsSearch,
              ),
              hintText: '${'hint_text_choose_category'.tr}...',
            ),
            SizedBox(height: height / 36),
            TitleLabelWidget(
              "Location".tr,
              fontSize: FontSize.title4(context),
            ),
            Obx(() {
              final locationAddressList =
                  _controller.filterSearchState.locationAddressList;
              final locationAddressNames =
                  _controller.filterSearchState.locationsAddressNameList;
              return CustomDropdownButton(
                textHint: 'select_company_work_place'.tr,
                labelList: locationAddressNames,
                values: locationAddressList,
                fillColor: Colors.white,
                onItemSelected: (value) async {
                  if (value == null) return;
                  _controller.filterSearchState.locationAddress = value;
                },
                setInitialValue: false,
              );
            }),
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
            const Divider(color: SippoColor.grey),
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
            await _controller.onApplyFilterSubmitted().then((_) => Get.back());
          },
          text: "apply_now".tr,
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
                        ? SippoColor.primarycolor
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
                        ? SippoColor.primarycolor
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
            activeColor: SippoColor.primarycolor,
            labels: RangeLabels(
              _controller.filterSearchState.rangeSalary.start
                  .roundToDouble()
                  .toString(),
              _controller.filterSearchState.rangeSalary.end.round().toString(),
            ),
            onChanged: (values) {
              _controller.filterSearchState.rangeSalary = values;
            },
          );
        }),
        SizedBox(height: height / 64),
        const MinMaxSalaryMessageTextWidget(),
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
