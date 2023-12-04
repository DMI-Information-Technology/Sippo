import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_controller/user_profile_controller/professions_user_controller.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import 'package:jobspot/sippo_custom_widget/success_message_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/edit_add_specialization_company.dart';

class SippoUserProfessions extends StatefulWidget {
  const SippoUserProfessions({super.key});

  @override
  State<SippoUserProfessions> createState() => _SippoUserProfessionsState();
}

class _SippoUserProfessionsState extends State<SippoUserProfessions> {
  final _controller = ProfessionsUserController.instance;

  @override
  Widget build(BuildContext context) {
    return LoadingScaffold(
      controller: _controller.loadingOverly,
      appBar: AppBar(
        title: Text(
          'select_professions'.tr,
          style: dmsbold,
        ),
        automaticallyImplyLeading: true,
      ),
      body: BodyWidget(
        paddingTop: EdgeInsets.all(context.fromWidth(CustomStyle.paddingValue)),
        topScreen: Center(
          child: Text(
            'select_professions_message'.tr,
            textAlign: TextAlign.center,
            style: dmsmedium.copyWith(fontSize: FontSize.paragraph3(context)),
          ),
        ),
        paddingContent: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.paddingValue),
        ),
        child: Obx(() {
          if (_controller.fetchStates.isLoading) return const SizedBox.shrink();
          if (_controller.fetchStates.isSuccess &&
              _controller.professionsLength > 0)
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
                        .professions[index - (isStateChanged ? 1 : 0)];
                    return SelectedSpecializationCardWidget(
                      title: item.name ?? "",
                      isSelected: _controller.fromSelectedProfession(item),
                      tapToggle: (value) {
                        _controller.toggleProfessionUser(item);
                      },
                    );
                  });
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: context.fromHeight(CustomStyle.spaceBetween),
                  );
                },
                itemCount:
                    _controller.professionsLength + (isStateChanged ? 1 : 0),
              );
            });
          return Center(
            child: Text(
              'message_no_profession_found'.tr,
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
              _controller.updateProfessions();
            },
            text: 'save'.tr),
      ),
    );
  }
}
