import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/company_post_widget.dart';

import 'jobstop_aboutus.dart';

class SippoUserSocial extends StatefulWidget {
  const SippoUserSocial({Key? key}) : super(key: key);

  @override
  State<SippoUserSocial> createState() => _SippoUserSocialState();
}

class _SippoUserSocialState extends State<SippoUserSocial> {
  static const List<String> list = ["Posting", "My connection"];

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(),
      body: BodyWidget(
        isScrollable: false,
        paddingContent: EdgeInsets.symmetric(horizontal: context.width / 36),
        child: (selected == 0)
            ? ListView.separated(
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
                    height: context.fromHeight(CustomStyle.spaceBetween)),
              )
            : GridView.builder(
                itemCount: 0,
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
              ),
        paddingBottom: EdgeInsets.symmetric(
          vertical: context.height / 36,
          horizontal: context.width / 36,
        ),
        bottomScreen: SizedBox(
          height: height / 20,
          width: width / 1,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return InkWell(
                highlightColor: Jobstopcolor.transparent,
                splashColor: Jobstopcolor.transparent,
                onTap: () {
                  setState(() {
                    selected = index;
                  });
                },
                child: Container(
                  width: width / 2.25,
                  margin: EdgeInsets.only(right: width / 36),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: selected == index
                        ? Jobstopcolor.primarycolor
                        : Jobstopcolor.lightprimary,
                  ),
                  child: Center(
                    child: Text(
                      list[index],
                      style: selected == index
                          ? dmsbold.copyWith(
                              fontSize: 14, color: Jobstopcolor.white)
                          : dmsbold.copyWith(
                              fontSize: 14, color: Jobstopcolor.primarycolor),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
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
