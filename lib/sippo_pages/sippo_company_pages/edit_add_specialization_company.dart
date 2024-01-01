import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/company_profile_controller/edit_add_specialization_company_controller.dart';
import 'package:sippo/sippo_custom_widget/body_widget.dart';
import 'package:sippo/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import 'package:sippo/sippo_custom_widget/success_message_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';

class EditAddSpecializationCompany extends StatefulWidget {
  const EditAddSpecializationCompany({super.key});

  @override
  State<EditAddSpecializationCompany> createState() =>
      _EditAddSpecializationCompanyState();
}

class _EditAddSpecializationCompanyState
    extends State<EditAddSpecializationCompany> {
  final _controller = EditAddSpecializationCompanyController.instance;

  @override
  Widget build(BuildContext context) {
    return LoadingScaffold(
      controller: _controller.loadingOverly,
      appBar: AppBar(
        backgroundColor: SippoColor.backgroudHome,
        titleSpacing: 0.0,
        title: Text(
          'label_specialization_company'.tr,
          style: dmsregular.copyWith(
            fontSize: FontSize.title4(context),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _controller.fetchSpecializations();
        },
        child: BodyWidget(
          paddingContent: EdgeInsets.symmetric(
            horizontal: context.fromWidth(CustomStyle.paddingValue),
          ),
          child: Obx(() {
            if (_controller.fetchStates.isLoading)
              return const SizedBox.shrink();
            if (_controller.fetchStates.isSuccess &&
                _controller.specializationsLength > 0)
              return Obx(() {
                final isStateChanged = _controller.isModifyStateChanged;
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return Obx(() {
                      if (isStateChanged && index == 0) {
                        if (_controller.modifyStates.isWarning)
                          return CardNotifyMessage.warning(
                            state: _controller.modifyStates,
                            onCancelTap: () => _controller.resetState(),
                            bottomSpaceValue: 0.0,
                          );
                        if (_controller.modifyStates.isError)
                          return CardNotifyMessage.error(
                            state: _controller.modifyStates,
                            onCancelTap: () => _controller.resetState(),
                            bottomSpaceValue: 0.0,
                          );
                      }
                      final item = _controller
                          .specializations[index - (isStateChanged ? 1 : 0)];
                      return SelectedSpecializationCardWidget(
                        title: item.name ?? "",
                        isSelected: _controller.fromSelectedSpecial(item),
                        tapToggle: (value) {
                          _controller.toggleSpecialization(item);
                        },
                      );
                    });
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: context.fromHeight(CustomStyle.spaceBetween),
                    );
                  },
                  itemCount: _controller.specializationsLength +
                      (isStateChanged ? 1 : 0),
                );
              });
            return Center(
              child: Text(
                'message_no_specializations_found'.tr,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: dmsbold.copyWith(
                  color: SippoColor.primarycolor,
                  fontSize: FontSize.title3(context),
                ),
              ),
            );
          }),
          paddingBottom: EdgeInsets.all(
            context.fromWidth(CustomStyle.paddingValue),
          ),
          bottomScreen: CustomButton(
              onTapped: () {
                _controller.updateSpecializations();
              },
              text: 'save'.tr),
        ),
      ),
    );
  }
}

class SelectedSpecializationCardWidget extends StatelessWidget {
  const SelectedSpecializationCardWidget({
    super.key,
    required this.isSelected,
    required this.title,
    required this.tapToggle,
  });

  final String title;
  final bool isSelected;
  final void Function(bool? value) tapToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isSelected ? SippoColor.primarycolor : Colors.black26,
          width: 2.0,
        ),
        color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.white,
      ),
      child: CheckboxListTile(
        title: AutoSizeText(
          textAlign: TextAlign.start,
          title,
          style: dmsbold.copyWith(
            color: isSelected ? SippoColor.primarycolor : null,
            fontSize: FontSize.title5(context),
          ),
        ),
        value: isSelected,
        onChanged: tapToggle,
        activeColor: SippoColor.primarycolor,
      ),
    );
  }
}
