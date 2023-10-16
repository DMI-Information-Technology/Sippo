import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/company_profile_controller/company_edit_add_job_controller.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';

import 'package:jobspot/sippo_custom_widget/ConditionalWidget.dart';
import 'package:jobspot/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:jobspot/sippo_custom_widget/custom_drop_down_button.dart';
import 'package:jobspot/sippo_custom_widget/success_message_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

class SippoCompanyEditAddJobs extends StatefulWidget {
  const SippoCompanyEditAddJobs({Key? key}) : super(key: key);

  @override
  State<SippoCompanyEditAddJobs> createState() =>
      _SippoCompanyEditAddJobsState();
}

class _SippoCompanyEditAddJobsState extends State<SippoCompanyEditAddJobs> {
  String? event;
  final _controller = CompanyEditAddJobController.instance;
  late final CompanyEditAddJobState jobState;

  @override
  void initState() {
    super.initState();
    jobState = _controller.newJobState;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: BodyWidget(
        isScrollable: true,
        paddingContent: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.paddingValue),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (_controller.isEditing ? "edit_job" : "add_a_job").tr,
              style: dmsbold.copyWith(
                fontSize: FontSize.title3(context),
                color: Jobstopcolor.primarycolor,
              ),
            ),
            _buildLoadingProgress(context),
            SizedBox(height: height / 36),
            Obx(() => ConditionalWidget(
                  _controller.states.isSuccess,
                  data: _controller.states,
                  guaranteedBuilder: (context, data) =>
                      CardNotifyMessage.success(
                    state: data,
                    onCancelTap: () =>
                        _controller.changeStates(isSuccess: false, message: ''),
                  ),
                )),
            Obx(() => ConditionalWidget(
                  _controller.states.isError,
                  data: _controller.states,
                  guaranteedBuilder: (_, data) => CardNotifyMessage.error(
                    state: data,
                    onCancelTap: () =>
                        _controller.changeStates(isError: false, message: ''),
                  ),
                )),
            Obx(() => ConditionalWidget(
                  _controller.states.isWarning,
                  data: _controller.states,
                  guaranteedBuilder: (context, data) =>
                      CardNotifyMessage.warning(
                    state: data,
                    onCancelTap: () =>
                        _controller.changeStates(isWarning: false, message: ''),
                  ),
                )),
            _buildPositionOption(context),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            _buildRequirementsOption(context),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            _buildWorkplaceOption(context),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            _buildWorkLocationOption(context),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            _buildSpecializationOption(context),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            _buildEmploymentTypeOption(context),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            _buildLevelExperienceOption(context),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            _buildRangeSalarySlideOption(context),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            _buildDescriptionOption(context),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.close,
            size: 20,
          )),
      actions: [
        InkWell(
          onTap: () async {
            // Navigator.push(context, MaterialPageRoute(
            //   builder: (context) {
            //     return const JobstopShared();
            //   },
            // ));
            await _controller.onSavedSubmitted();
          },
          child: Padding(
            padding: EdgeInsets.all(context.fromWidth(
              CustomStyle.paddingValue,
            )),
            child: Text(
              "Post",
              style: dmsbold.copyWith(
                fontSize: FontSize.title5(context),
                color: Jobstopcolor.primarycolor,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildRangeSalarySlideOption(BuildContext context) {
    return Obx(() => AddJobOptionsCard(
          onTapAction: () {
            jobState.showAllActionButtonOptions();
            jobState.setSalaryRange(jobState.rangeSalary);
            jobState.swithcActionSalary();
          },
          title: "Salary",
          editorWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Slide Left and Right to Set Salary Range',
                textAlign: TextAlign.start,
                style:
                    dmsregular.copyWith(fontSize: FontSize.paragraph3(context)),
              ),
              InputCloser(
                paddingHButtonValue: context.fromWidth(CustomStyle.xxxl),
                onCloseTap: () {
                  jobState.swithcActionSalary();
                },
                child: RangeSlider(
                  values: jobState.rangeSalary,
                  max: CompanyEditAddJobState.MAX_SALARY_RANGE,
                  min: CompanyEditAddJobState.MIN_SALARY_RANGE,
                  divisions: (CompanyEditAddJobState.MAX_SALARY_RANGE -
                          CompanyEditAddJobState.MIN_SALARY_RANGE) ~/
                      100,
                  labels: RangeLabels(
                    jobState.rangeSalary.start.round().toString(),
                    jobState.rangeSalary.end.round().toString(),
                  ),
                  onChanged: (values) {
                    jobState.setSalaryRange(values);
                  },
                ),
                inputDone: jobState.salaryForamat != null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InputBorderedField(
                      fontColor: Jobstopcolor.primarycolor,
                      maxLength: 7,
                      controller: jobState.salaryFrom,
                      fillColor: Colors.grey[300],
                      onTextChanged: (_) => jobState.setSalaryRangeText(),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: context.fromWidth(CustomStyle.spaceBetween)),
                  Expanded(
                    child: InputBorderedField(
                      fontColor: Jobstopcolor.primarycolor,
                      maxLength: 7,
                      controller: jobState.salaryTo,
                      fillColor: Colors.grey[300],
                      onTextChanged: (_) => jobState.setSalaryRangeText(),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.fromHeight(CustomStyle.huge)),
              Text(
                'The accepted range salary start '
                'from ${CompanyEditAddJobState.MAX_SALARY_RANGE} '
                'to ${CompanyEditAddJobState.MAX_SALARY_RANGE}',
                textAlign: TextAlign.start,
                style: dmsregular.copyWith(
                    fontSize: FontSize.label(context),
                    color: Jobstopcolor.black),
              ),
            ],
          ),
          subTitle: jobState.salaryForamat,
          showActionButton: jobState.showActionSalary,
        ));
  }

  Widget _buildLevelExperienceOption(BuildContext context) {
    return Obx(() => AddJobOptionsCard(
        title: "Level Experience",
        subTitle: jobState.experienceLevel.label,
        onTapAction: () {
          _showLevelExperiences(context);
        }));
  }

  Widget _buildDescriptionOption(BuildContext context) {
    return Obx(() => AddJobOptionsCard(
          onTapAction: () {
            jobState.showAllActionButtonOptions();
            jobState.swithcActionDescription();
          },
          title: "Description",
          editorWidget: InputCloser(
            child: InputBorderedField(
              verticalPaddingValue: context.fromWidth(CustomStyle.paddingValue),
              maxLine: 5,
              initialValue: jobState.description,
              fillColor: Jobstopcolor.backgroudHome,
              onTextChanged: (value) => jobState.description = value,
            ),
            onCloseTap: () {
              jobState.swithcActionDescription();
            },
            inputDone: jobState.description.isNotEmpty,
          ),
          subTitle: jobState.description,
          showActionButton: jobState.showActionDescription,
        ));
  }

  Widget _buildEmploymentTypeOption(BuildContext context) {
    return Obx(() => AddJobOptionsCard(
        title: "Employment type",
        subTitle: jobState.employmentType,
        onTapAction: () {
          _showJobType(context);
        }));
  }

  Widget _buildWorkLocationOption(BuildContext context) {
    return Obx(
      () => AddJobOptionsCard(
        onTapAction: () {
          jobState.showAllActionButtonOptions();
          jobState.swithcActionLocation();
        },
        title: "Job location",
        editorWidget: InputCloser(
          child: CustomDropdownButton(
            textHint: 'Select Job work location',
            labelList: jobState.locationsLabel,
            values: jobState.locationsList,
            onItemSelected: (value) async {
              print(value);
              if (value != null) jobState.jobLocation = value;
            },
            setInitialValue: jobState.jobLocation.address != null,
            initialValue: jobState.jobLocation.address,
          ),
          inputDone: jobState.jobLocation.address?.isNotEmpty == true,
          onCloseTap: () {
            jobState.swithcActionLocation();
          },
        ),
        subTitle: jobState.jobLocation.address,
        showActionButton: jobState.showActionLocation,
      ),
    );
  }

  Widget _buildSpecializationOption(BuildContext context) {
    return Obx(
      () => AddJobOptionsCard(
        onTapAction: () {
          jobState.showAllActionButtonOptions();
          jobState.swithcActionSpecialization();
        },
        title: "Specialization",
        editorWidget: InputCloser(
          child: CustomDropdownButton(
            textHint: 'Select Specialization Job',
            labelList: jobState.specializationLabel,
            values: jobState.specializationList,
            onItemSelected: (value) async {
              if (value != null) jobState.specialization = value;
            },
            setInitialValue: jobState.specialization.id != null,
            initialValue: jobState.specialization.name,
          ),
          inputDone: jobState.specialization.id != null,
          onCloseTap: () {
            jobState.swithcActionSpecialization();
          },
        ),
        subTitle: jobState.specialization.name,
        showActionButton: jobState.showActionSpecialization,
      ),
    );
  }

  Widget _buildWorkplaceOption(BuildContext context) {
    return Obx(() => AddJobOptionsCard(
        title: "Type of workplace",
        subTitle: jobState.workPLaceType,
        onTapAction: () {
          _showWorkPlaceType(context);
        }));
  }

  Widget _buildRequirementsOption(BuildContext context) {
    return Obx(() => AddJobOptionsCard(
          onTapAction: () {
            jobState.showAllActionButtonOptions();
            jobState.swithcActionRequirements();
          },
          title: "Requirements",
          editorWidget: InputCloser(
            child: InputBorderedField(
              verticalPaddingValue: context.fromWidth(CustomStyle.paddingValue),
              maxLine: 2,
              initialValue: jobState.requirements,
              fillColor: Jobstopcolor.backgroudHome,
              onTextChanged: (value) => jobState.requirements = value,
            ),
            onCloseTap: () {
              jobState.swithcActionRequirements();
            },
            inputDone: jobState.requirements.isNotEmpty,
          ),
          subTitle: jobState.requirements,
          showActionButton: jobState.showActionRequirements,
        ));
  }

  Widget _buildPositionOption(BuildContext context) {
    return Obx(() => AddJobOptionsCard(
          onTapAction: () {
            jobState.showAllActionButtonOptions();
            jobState.swithcActionPosition();
          },
          title: "Job position",
          editorWidget: InputCloser(
            child: InputBorderedField(
              initialValue: jobState.position,
              fillColor: Jobstopcolor.backgroudHome,
              onTextChanged: (value) => jobState.position = value,
            ),
            onCloseTap: () {
              jobState.swithcActionPosition();
            },
            inputDone: jobState.position.isNotEmpty,
          ),
          subTitle: jobState.position,
          showActionButton: jobState.showActionPosition,
        ));
  }

  void _showWorkPlaceType(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;

    Get.bottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      ContainerBottomSheetWidget(
        children: [
          SizedBox(height: height / CustomStyle.spaceBetween),
          Text(
            "Choose the type of workplace",
            style: dmsbold.copyWith(
                fontSize: 16, color: Jobstopcolor.primarycolor),
          ),
          SizedBox(height: height / CustomStyle.xxxl),
          Text(
            "Decide and choose the type of place to work\naccording to what you want",
            style:
                dmsregular.copyWith(fontSize: 12, color: Jobstopcolor.darkgrey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height / CustomStyle.spaceBetween),
          ...List.generate(jobState.workPLaceTypeList.length, (i) {
            final e = jobState.workPLaceTypeList[i];
            return ListTile(
              title: Text(
                e.title,
                style: dmsmedium,
              ),
              subtitle: Text(
                e.description,
                style: dmsregular,
              ),
              trailing: Obx(
                () => Radio(
                  value: e.title,
                  groupValue: jobState.workPLaceType,
                  onChanged: (value) {
                    jobState.workPLaceType = value ?? jobState.workPLaceType;
                  },
                ),
              ),
              onTap: () => jobState.workPLaceType = e.title,
            );
          }),
        ],
      ),
    );
  }

  void _showJobType(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    Get.bottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      ContainerBottomSheetWidget.statefulBuilder(
        builder: (context, setState) => Column(
          children: [
            SizedBox(height: height / CustomStyle.spaceBetween),
            Text(
              "Choose Job Type",
              style: dmsbold.copyWith(
                fontSize: FontSize.title4(context),
                color: Jobstopcolor.primarycolor,
              ),
            ),
            SizedBox(height: height / CustomStyle.xxxl),
            Text(
              "Determine and choose the type of work according to\nwhat you want",
              style: dmsregular.copyWith(
                fontSize: FontSize.label(context),
                color: Jobstopcolor.darkgrey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height / CustomStyle.spaceBetween),
            ...jobState.employmentTypeList
                .map(
                  (eType) => ListTile(
                    title: Text(
                      eType,
                      style: dmsmedium,
                    ),
                    trailing: Obx(
                      () => Radio(
                        value: eType,
                        groupValue: jobState.employmentType,
                        onChanged: (value) {
                          jobState.employmentType =
                              value ?? jobState.employmentType;
                        },
                      ),
                    ),
                    onTap: () {
                      jobState.employmentType = eType;
                    },
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }

  void _showLevelExperiences(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    Get.bottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      ContainerBottomSheetWidget.statefulBuilder(
        builder: (context, setState) => Column(
          children: [
            SizedBox(height: height / CustomStyle.spaceBetween),
            Text(
              "Choose Level Experience",
              style: dmsbold.copyWith(
                fontSize: FontSize.title4(context),
                color: Jobstopcolor.primarycolor,
              ),
            ),
            SizedBox(height: height / CustomStyle.xxxl),
            Text(
              "Determine and choose the type of Level Experiences according to\nwhat you want",
              style: dmsregular.copyWith(
                fontSize: FontSize.label(context),
                color: Jobstopcolor.darkgrey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height / CustomStyle.spaceBetween),
            ...jobState.experienceLevelList
                .map(
                  (e) => ListTile(
                    title: Text(
                      e.label ?? "",
                      style: dmsmedium,
                    ),
                    trailing: Obx(
                      () => Radio(
                        value: e,
                        groupValue: jobState.experienceLevel,
                        onChanged: (value) {
                          jobState.experienceLevel =
                              value ?? jobState.experienceLevel;
                        },
                      ),
                    ),
                    onTap: () {
                      jobState.experienceLevel = e;
                    },
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingProgress(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Obx(() => ConditionalWidget(
          _controller.states.isLoading,
          guaranteedBuilder: (__, _) => Column(
            children: [
              SizedBox(height: height / 36),
              const Center(child: CircularProgressIndicator()),
            ],
          ),
        ));
  }
}

class AddJobOptionsCard extends StatefulWidget {
  final String title;
  final String? subTitle;
  final VoidCallback? onTapAction;
  final Widget? editorWidget;
  final bool showActionButton;

  const AddJobOptionsCard({
    required this.title,
    this.subTitle,
    this.onTapAction,
    this.editorWidget,
    this.showActionButton = true,
  });

  @override
  State<AddJobOptionsCard> createState() => _AddJobOptionsCardState();
}

class _AddJobOptionsCardState extends State<AddJobOptionsCard> {
  Widget? _buildEditorWidget() {
    if (widget.editorWidget == null && widget.subTitle == null) {
      return null;
    }
    if (widget.showActionButton == true &&
        (widget.subTitle == null ||
            (widget.subTitle != null && widget.subTitle!.isEmpty))) {
      return null;
    }
    if (widget.showActionButton == false && widget.editorWidget == null) {
      return null;
    }
    return AnimatedSwitcher(
        switchInCurve: Curves.linear,
        duration: Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          final slideAnimation = Tween<Offset>(
            begin: Offset(-1.0, 0.0),
            end: Offset(0.0, 0.0),
          ).animate(animation);
          return SlideTransition(
            position: slideAnimation,
            child: child,
          );
        },
        child: !widget.showActionButton
            ? widget.editorWidget
            : Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  widget.subTitle ?? 'unknown',
                  style: dmsregular,
                ),
              ));
  }

  @override
  Widget build(BuildContext context) {
    return RoundedBorderRadiusCardWidget(
      radiusValue: 12,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.symmetric(
        horizontal: context.fromWidth(CustomStyle.paddingValue),
        vertical: context.fromWidth(
          widget.showActionButton ? CustomStyle.huge : CustomStyle.paddingValue,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          widget.title,
          style: dmsmedium.copyWith(color: Jobstopcolor.primarycolor),
        ),
        subtitle: _buildEditorWidget(),
        trailing:
            widget.showActionButton == true ? _buildEditIcon(context) : null,
      ),
    );
  }

  Widget _buildEditIcon(BuildContext context) {
    return InkWell(
      onTap: widget.onTapAction,
      child: widget.subTitle == null ||
              (widget.subTitle != null && widget.subTitle!.isEmpty)
          ? CircleAvatar(
              radius: 12,
              backgroundColor: Jobstopcolor.lightprimary3,
              child: Icon(
                Icons.add,
                size: context.fromHeight(CustomStyle.xl),
                color: Jobstopcolor.primarycolor,
              ))
          : Image.asset(
              JobstopPngImg.edit,
              color: Jobstopcolor.primarycolor,
              height: context.fromHeight(CustomStyle.l),
              width: context.fromHeight(CustomStyle.l),
            ),
    );
  }
}
