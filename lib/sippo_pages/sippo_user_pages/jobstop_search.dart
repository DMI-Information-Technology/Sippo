import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/custom_body_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../../JobGlobalclass/sippo_customstyle.dart';
import '../../sippo_custom_widget/save_job_card_widget.dart';

class JobSearch extends StatefulWidget {
  const JobSearch({Key? key}) : super(key: key);

  @override
  State<JobSearch> createState() => _JobSearchState();
}

class _JobSearchState extends State<JobSearch> {
  TextEditingController search = TextEditingController();
  TextEditingController loaction = TextEditingController();
  List<String> list = ["Senior designer", "Designer", "Full-time"];
  List<String> imagelist = [JobstopPngImg.google, JobstopPngImg.dribbble];
  List<String> name = ["UI/UX Designer", "Lead Designer"];
  int selected = 0;
  Size? size;
  double height = 0;
  double width = 0;
  final _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("hello");
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _updateExpandedHeight());
  }

  void _updateExpandedHeight() {
    final RenderBox renderBox =
        _key.currentContext!.findRenderObject() as RenderBox;
    final childHeight = renderBox.size.height;
    print("childHeight: $childHeight");
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size?.height ?? 0;
    width = size?.width ?? 0;

    return Scaffold(
      body: CustomBodyWidget.itemBuilder(
        expandedAppBarHeight: context.fromHeight(
          3.09,
        ),
        expandedAppBar: _buildScrollableTopAppBar(context),
        itemCount: 250,
        itemBuilder: (context, index) {
          return SavedJobCard(
            imagePath: JobstopPngImg.google,
            jobTitle: "UI/UX Designer",
            companyLocation: 'Company Location',
            jobType: 'Full time',
            jobCategory: 'Design',
            jobPosition: 'Senior Designer',
            timeAgo: '25 minutes ago',
            salary: '\$155K',
            onActionTap: () {},
            isLastWidget: index == 249,
          );
        },
      ),
    );
  }

  Widget _buildScrollableTopAppBar(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        key: _key,
        children: [
          _buildTopSearchBar(context),
          SizedBox(
            height: height / 64,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.fromWidth(CustomStyle.paddingValue2),
                ),
                child: Container(
                  height: height / 18,
                  width: height / 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Jobstopcolor.primarycolor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(JobstopPngImg.filter),
                  ),
                ),
              ),
              SizedBox(
                height: height / 18,
                width: width / 1.22,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return CustomChip(
                      borderRadius: context.fromWidth(CustomStyle.m),
                      margin: EdgeInsets.symmetric(
                        horizontal: context.fromWidth(
                          CustomStyle.spaceBetween,
                        ),
                      ),
                      backgroundColor: selected == index
                          ? Jobstopcolor.primarycolor
                          : Colors.grey[300],
                      paddingValue:
                          context.fromWidth(CustomStyle.paddingValue2),
                      onTap: () => setState(() => selected = index),
                      child: Text(
                        list[index],
                        style: dmsregular.copyWith(
                          fontSize: 12,
                          color: selected == index
                              ? Jobstopcolor.white
                              : Jobstopcolor.primarycolor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildTopSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        color: Jobstopcolor.primarycolor,
        // Change this to your desired color
        image: DecorationImage(
          image: AssetImage(JobstopPngImg.backgroundProf),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            context.fromHeight(CustomStyle.paddingValue),
          ),
          child: Column(
            children: [
              InputBorderedField(
                height: context.fromHeight(CustomStyle.inputBorderedSize),
                hintText: "Design".tr,
                fontSize: FontSize.paragraph2(context),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(
                    context.fromHeight(CustomStyle.xxl),
                  ),
                  child: Image.asset(
                    JobstopPngImg.search,
                    height: context.fromHeight(CustomStyle.l),
                    width: context.fromHeight(CustomStyle.l),
                  ),
                ),
              ),
              SizedBox(
                height: context.fromHeight(CustomStyle.spaceBetween),
              ),
              InputBorderedField(
                height: context.fromHeight(CustomStyle.inputBorderedSize),
                fontSize: FontSize.paragraph2(context),
                hintText: 'Location',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(
                    context.fromHeight(CustomStyle.xxl),
                  ),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: Jobstopcolor.secondary,
                    size: context.fromHeight(CustomStyle.m),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
