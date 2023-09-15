import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';

import '../../sippo_custom_widget/container_bottom_sheet_widget.dart';
import '../../sippo_custom_widget/save_job_card_widget.dart';
import '../../sippo_custom_widget/setting_item_widget.dart';
import '../sippo_user_pages/no_resource_screen.dart';

class JobstopOrder extends StatefulWidget {
  const JobstopOrder({Key? key}) : super(key: key);

  @override
  State<JobstopOrder> createState() => _JobstopOrderState();
}

class _JobstopOrderState extends State<JobstopOrder> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  int selectlist = 0;
  final List<String> imagelist = [
    JobstopPngImg.google,
    JobstopPngImg.dribbble,
    JobstopPngImg.twitterlogo,
    JobstopPngImg.apple,
    JobstopPngImg.facebooklogo,
  ];
  List<String> bottomimg = [
    JobstopPngImg.subtract,
    JobstopPngImg.union,
    JobstopPngImg.deleted,
    JobstopPngImg.applay
  ];
  final List<String> bottomname = ["Send message", "Shared", "Delete", "Apply"];
  final List<String> name = [
    "UI/UX Designer",
    "Lead Designer",
    "UX Researcher",
  ];
  int _selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Save_Job".tr,
          style: dmsbold.copyWith(fontSize: 20),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(kToolbarHeight / 3),
            child: InkWell(
              onTap: () {},
              child: AutoSizeText(
                "Delete all",
                style: dmsregular.copyWith(
                  fontSize: FontSize.label(context),
                  color: Jobstopcolor.secondary,
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: imagelist.isEmpty
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          imagelist.isEmpty ? _buildNoResourceMessage() : _buildSavedJobList(),
        ],
      ),
    );
  }

  NoResourceScreen _buildNoResourceMessage() {
    return NoResourceScreen(
      title: 'No Savings',
      description:
          "You don't have any jobs saved, please\nfind it in search to save jobs",
      image: JobstopPngImg.nosavejob,
    );
  }

  Expanded _buildSavedJobList() {
    return Expanded(
      child: ListView.builder(
        itemCount: imagelist.length,
        itemBuilder: (context, index) {
          return InkWell(
            highlightColor: Jobstopcolor.transparent,
            splashColor: Jobstopcolor.transparent,
            onTap: () {
              // const Specialization();
            },
            child: JobPostingCard(
              imagePath: imagelist[index],
              timeAgo: '25 minutes ago',
              onActionTap: () => _openBottomSheetOption(context, index),
              isSaved: true,
            ),
          );
        },
      ),
    );
  }

  void _openBottomSheetOption(
    BuildContext context,
    int savedJobID,
  ) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
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
            // Obx(
            //   () =>
            SettingItemWidget(
              title: "Shared",
              icon: Image.asset(
                JobstopPngImg.union,
                color: _selectedOption == 0
                    ? Colors.white
                    : Jobstopcolor.primarycolor,
                height: height / 32,
              ),
              onTap: () {
                setState(() => _selectedOption = 0);
                print("shared saved job with id: $savedJobID");
              },
              isHavingTrailingIcon: false,
              isBordered: false,
              contentPadding: width / 12,
              isSelected: _selectedOption == 0,
            ),
            // ),
            // Obx(
            //   () =>
            SettingItemWidget(
              title: 'Delete',
              icon: Image.asset(
                JobstopPngImg.deleted,
                color: _selectedOption == 1
                    ? Colors.white
                    : Jobstopcolor.primarycolor,
                height: height / 32,
              ),
              onTap: () {
                setState(() => _selectedOption = 1);
                print("delete saved job with id: $savedJobID");
              },
              isHavingTrailingIcon: false,
              isBordered: false,
              contentPadding: width / 12,
              isSelected: _selectedOption == 1,
            ),
            // ),
            // Obx(
            //   () =>
            SettingItemWidget(
              title: 'Apply'.tr,
              icon: Image.asset(
                JobstopPngImg.applay,
                color: _selectedOption == 2
                    ? Colors.white
                    : Jobstopcolor.primarycolor,
                height: height / 32,
              ),
              onTap: () {
                setState(() => _selectedOption = 2);

                print("apply saved job with id: $savedJobID");
              },
              isHavingTrailingIcon: false,
              isBordered: false,
              contentPadding: width / 12,
              isSelected: _selectedOption == 2,
            ),
            // ),
          ],
        ),
      ),
    ).then((value) => setState(() => _selectedOption = -1));
  }
}

// Widget _buildTag(String text) {
//   return Container(
//     height: 28,
//     padding: const EdgeInsets.symmetric(horizontal: 8),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(5),
//       color: Colors.grey[200],
//     ),
//     child: Center(
//       child: Text(
//         text,
//         style: const TextStyle(
//           fontSize: 12,
//           color: Colors.grey,
//         ),
//       ),
//     ),
//   );
// }
