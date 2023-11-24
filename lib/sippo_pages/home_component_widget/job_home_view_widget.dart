import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JobServices/app_local_language_services/app_local_language_service.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/sippo_controller/home_controllers/job_home_view_controller.dart';
import 'package:jobspot/sippo_custom_widget/job_home_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/utils/helper.dart';
import 'package:jobspot/utils/states.dart';
import 'package:lottie/lottie.dart';

class JobHomeViewWidget extends StatefulWidget {
  const JobHomeViewWidget({super.key});

  @override
  State<JobHomeViewWidget> createState() => _JobHomeViewWidgetState();
}

class _JobHomeViewWidgetState extends State<JobHomeViewWidget> {
  final _controller = Get.put(JobsHomeViewController());
  final moreArrow = InkWell(
    onTap: () => Get.toNamed(SippoRoutes.sippoJobFilterSearch),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() {
        final iconDir = switch (GlobalStorageService.savedLanguage) {
          LocaleLanguageType.arabic => Icons.arrow_circle_left_rounded,
          LocaleLanguageType.english => Icons.arrow_circle_right_rounded,
        };
        return Icon(
          iconDir,
          color: SippoColor.secondary,
          size: 75,
        );
      }),
    ),
  );

  @override
  Widget build(BuildContext context) {
    print('_JobHomeViewWidgetState.build');

    return Obx(() => FutureBuilder(
          future: _controller.jobStatesAsFuture,
          builder: (context, snapshot) {
            final states = snapshot.data;
            if (states != null) {
              if (states.isError)
                return _buildFieldJobsMessage(context, states);
              if (states.isSuccess && _controller.jobsListLength > 0)
                return _buildJobsCards(context);
              else if (states.isLoading)
                return Center(
                  child: Lottie.asset(
                    JobstopPngImg.loadingProgress,
                    height: context.height / 6,
                  ),
                );
            }
            return Center(
              child: Text(
                'no_jobs_found_title'.tr,
                textAlign: TextAlign.center,
                style: dmsbold.copyWith(
                  color: SippoColor.primarycolor,
                  fontSize: FontSize.title4(context),
                ),
              ),
            );
          },
        ));
  }

  Widget _buildFieldJobsMessage(BuildContext context, States states) {
    return Center(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.fromWidth(CustomStyle.s)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              states.message ?? 'something_wrong_happened'.tr,
              style: dmsregular.copyWith(
                fontSize: FontSize.paragraph3(context),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: context.fromHeight(CustomStyle.huge)),
            SizedBox(
              width: context.fromWidth(CustomStyle.overBy3),
              height: context.fromHeight(14),
              child: CustomButton(
                onTapped: () {
                  _controller.refreshJobs();
                },
                text: 'try_again'.tr,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildJobsCards(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.spaceBetween),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...List.generate(_controller.jobsList.length, (index) {
              return Obx(() {
                final jobList = _controller.jobsList;
                final item = jobList[index];
                return JobHomeCard(
                  padding: EdgeInsets.only(
                    right: context.fromWidth(CustomStyle.paddingValue),
                  ),
                  width: context.width / 1.3,
                  jobDetailsPost: item,
                  canApply: GlobalStorageService.isUser,
                  imagePath: item.company?.profileImage?.url ?? "",
                  onImageProfileTap: () {
                    SharedGlobalDataService.onCompanyTap(item.company);
                  },
                  onCardTap: () async {
                    SharedGlobalDataService.onJobTap(
                      item,
                      handler: (job) {
                        if (job?.isSaved != item.isSaved)
                          _controller.refreshJobs();
                      },
                    );
                  },
                  onApplyTap: GlobalStorageService.isUser
                      ? () async {
                          SharedGlobalDataService.onJobTap(
                            item,
                            handler: (job) {
                              if (job?.isSaved != item.isSaved)
                                _controller.refreshJobs();
                            },
                            args: {SharedGlobalDataService.GO_TO_APPLY: true},
                          );
                        }
                      : null,
                  onActionTap: GlobalStorageService.isUser
                      ? () => _controller.onToggleSavedJobsTap(item.id, index)
                      : null,
                  isEditable: false,
                  onAddressTextTap: (location) async {
                    lunchMapWithLocation(
                      location.dLatitude,
                      location.dLongitude,
                    );
                  },
                );
              });
            }),
            Obx(() {
              return _controller.jobsListLength > 0
                  ? moreArrow
                  : const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}
