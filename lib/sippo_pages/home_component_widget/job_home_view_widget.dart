import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/sippo_controller/home_controllers/job_home_view_controller.dart';
import 'package:jobspot/sippo_custom_widget/job_home_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/utils/helper.dart';
import 'package:jobspot/utils/states.dart';

class JobHomeViewWidget extends StatefulWidget {
  const JobHomeViewWidget({super.key});

  @override
  State<JobHomeViewWidget> createState() => _JobHomeViewWidgetState();
}

class _JobHomeViewWidgetState extends State<JobHomeViewWidget> {
  final _controller = Get.put(JobsHomeViewController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => FutureBuilder(
          future: _controller.jobStatesAsFuture,
          builder: (context, snapshot) {
            final states = snapshot.data;
            if (states != null) {
              if (states.isError)
                return _buildFieldJobsMessage(context, states);
              if (states.isSuccess && _controller.jobsListLength > 0)
                return _buildJobsCards(context);
              if (states.isLoading && _controller.jobsList.isNotEmpty)
                return _buildJobsCards(context);
              else if (states.isLoading)
                return const Center(child: CircularProgressIndicator());
            }
            return Center(
              child: Text(
                'No Jobs Found',
                textAlign: TextAlign.center,
                style: dmsbold.copyWith(
                  color: Jobstopcolor.primarycolor,
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
            ),
            SizedBox(height: context.fromHeight(CustomStyle.huge)),
            SizedBox(
              width: context.fromWidth(CustomStyle.overBy3),
              height: context.fromHeight(12),
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
                    right: index == jobList.length - 1
                        ? 0.0
                        : context.fromWidth(CustomStyle.paddingValue),
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
                  ? InkWell(
                      onTap: () =>
                          Get.toNamed(SippoRoutes.sippoJobFilterSearch),
                      child: Padding(
                        padding: EdgeInsets.all(
                          context.fromWidth(CustomStyle.xxl),
                        ),
                        child: Icon(
                          Icons.arrow_circle_right_rounded,
                          color: Jobstopcolor.secondary,
                          size: context.fromHeight(12),
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}
