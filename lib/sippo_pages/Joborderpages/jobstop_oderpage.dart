import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../../sippo_custom_widget/container_bottom_sheet_widget.dart';
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
            child: SavedJobCard(
              imagePath: imagelist[index],
              jobTitle: 'Job Title',
              companyLocation: 'Company Location',
              jobType: 'Full time',
              jobCategory: 'Design',
              jobPosition: 'Senior Designer',
              timeAgo: '25 minutes ago',
              salary: '\$15K',
              showList: () => _openBottomSheetOption(context, index),
              isLastWidget: index == imagelist.length - 1,
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

class SavedJobCard extends StatelessWidget {
  final String imagePath;
  final String jobTitle;
  final String companyLocation;
  final String jobType;
  final String jobCategory;
  final String jobPosition;
  final String timeAgo;
  final String salary;
  final VoidCallback showList;
  final bool isLastWidget;

  const SavedJobCard({
    required this.imagePath,
    required this.jobTitle,
    required this.companyLocation,
    required this.jobType,
    required this.jobCategory,
    required this.jobPosition,
    required this.timeAgo,
    required this.salary,
    required this.showList,
    this.isLastWidget = false,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return RoundedBorderRadiusCardWidget(
      margin: EdgeInsets.only(
        right: width / 24,
        left: width / 24,
        top: width / 32,
        bottom: isLastWidget ? width / 16 : 0.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopImageButtonOptionCard(context),
          SizedBox(height: height / 64),
          _buildTitleAndDescriptionColumn(context),
          SizedBox(height: height / 64),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCustomChip(context, jobType),
              _buildCustomChip(context, jobCategory),
              _buildCustomChip(context, jobPosition),
            ],
          ),
          SizedBox(height: height / 64),
          _buildArriveTimeAndPriceRow(),
        ],
      ),
    );
  }

  Row _buildTopImageButtonOptionCard(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: Colors.grey[200],
          child: Image.asset(
            imagePath,
            height: height / 28,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: showList, // Replace with your function
          child: Image.asset(
            JobstopPngImg.dots,
            height: (kIsWeb ? height : width) / 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Column _buildTitleAndDescriptionColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          jobTitle,
          style: TextStyle(
            fontSize: FontSize.title6(context),
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        AutoSizeText(
          companyLocation,
          style:  TextStyle(
            fontSize: FontSize.paragraph4(context),
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Row _buildArriveTimeAndPriceRow() {
    return Row(
      children: [
        Text(
          timeAgo,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
        ),
        const Spacer(),
        Text(
          salary,
          style: const TextStyle(
            fontSize: 14,
            color: Jobstopcolor.primarycolor, // Use appropriate color
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '/Mo',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  CustomChip _buildCustomChip(BuildContext context, String text) {
    Size size = MediaQuery.of(context).size;
    // double height = size.height;
    double width = size.width;
    return CustomChip(
      onTap: () {},
      backgroundColor: Colors.grey[200],
      child: AutoSizeText(
        text,
        style: dmsregular.copyWith(
          fontSize: FontSize.label(context),
          color: Colors.black54,
        ),
      ),
      paddingValue: width / 64,
      borderRadius: width / 64,
    );
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
}
