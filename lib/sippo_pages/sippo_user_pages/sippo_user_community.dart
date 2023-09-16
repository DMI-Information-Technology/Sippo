import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/company_post_widget.dart';

import '../../JopController/user_community_controller/user_community_controller.dart';
import '../../sippo_custom_widget/widgets.dart';
import '../Jobpostpages/jobstop_aboutus.dart';

class SippoUserCommunity extends StatefulWidget {
  const SippoUserCommunity({Key? key}) : super(key: key);

  @override
  State<SippoUserCommunity> createState() => _SippoUserCommunityState();
}

class _SippoUserCommunityState extends State<SippoUserCommunity> {
  final _controller = Get.put(UserCommunityController());
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BodyWidget(
        isScrollable: false,
        paddingContent: EdgeInsets.symmetric(horizontal: context.width / 36),
        child: Obx(() => [
              ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return PostWidget(
                    authorName: "Arnold Leonardo",
                    timeAgo: "21 minutes ago",
                    postTitle:
                        "What are the characteristics of a fake job call form?",
                    postContent:
                        "Because I always find fake job calls so I'm confused which job to take can you share your knowledge here? thank you",
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: context.fromHeight(CustomStyle.spaceBetween),
                ),
              ),
              GridView.builder(
                itemCount: 5,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 2 / 2.2,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Get.to(() => const JobstopAbouts()),
                    child: ConnectionCard(
                      imageAsset: JobstopPngImg.facebooklogo,
                      connectionName: "Facebook",
                      followerCount: "1M Followers",
                    ),
                  );
                },
              )
            ][_controller.selected]),
        paddingBottom: EdgeInsets.symmetric(
          vertical: context.height / 36,
          horizontal: context.width / 36,
        ),
        bottomScreen: _buildBottomControlButtons(context),
      ),
    );
  }

  Widget _buildBottomControlButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => SizedBox(
              width: context.width / 2.4,
              height: context.height / 18,
              child: CustomButton(
                onTappeed: () {
                  _controller.switchSelectedTap(0);
                },
                text: "Posts".tr,
                backgroundColor: _controller.selected == 0
                    ? Jobstopcolor.primarycolor
                    : Jobstopcolor.lightprimary,
                textColor: _controller.selected == 0
                    ? Jobstopcolor.white
                    : Jobstopcolor.primarycolor,
              ),
            )),
        Obx(() => SizedBox(
              width: context.width / 2.4,
              height: context.height / 18,
              child: CustomButton(
                onTappeed: () {
                  _controller.resetStates();
                  _controller.switchSelectedTap(1);
                },
                text: "My Connections".tr,
                backgroundColor: _controller.selected == 1
                    ? Jobstopcolor.primarycolor
                    : Jobstopcolor.lightprimary,
                textColor: _controller.selected == 1
                    ? Jobstopcolor.white
                    : Jobstopcolor.primarycolor,
              ),
            )),
      ],
    );
  }
}

class ConnectionCard extends StatelessWidget {
  final String imageAsset;
  final String connectionName;
  final String followerCount;

  ConnectionCard({
    required this.imageAsset,
    required this.connectionName,
    required this.followerCount,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageAsset,
            height: height / 16,
          ),
          SizedBox(
            height: height / 46,
          ),
          Text(
            connectionName,
            style: TextStyle(
              fontSize: 14,
              color: Jobstopcolor.primarycolor, // استبدل باللون الخاص بك
            ),
          ),
          SizedBox(
            height: height / 100,
          ),
          Text(
            followerCount,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: height / 60,
          ),
          Container(
            height: height / 25,
            width: width / 3.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Jobstopcolor.primarycolor, // استبدل باللون الخاص بك
              ),
            ),
            child: Center(
              child: Text(
                "Follow",
                style: TextStyle(
                  fontSize: 12,
                  color: Jobstopcolor.primarycolor, // استبدل باللون الخاص بك
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
