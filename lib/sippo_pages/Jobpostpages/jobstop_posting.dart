import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';

import 'jobstop_aboutus.dart';

class SippoUserSocial extends StatefulWidget {
  const SippoUserSocial({Key? key}) : super(key: key);

  @override
  State<SippoUserSocial> createState() => _SippoUserSocialState();
}

class _SippoUserSocialState extends State<SippoUserSocial> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  List<String> list = ["Posting", "My connection"];
  List<String> connectionimg = [
    JobstopPngImg.googlelogo,
    JobstopPngImg.dribbblelogo,
    JobstopPngImg.twitterlogo,
    JobstopPngImg.applelogo,
    JobstopPngImg.facebooklogo,
    JobstopPngImg.microsoft
  ];
  List<String> connectionname = [
    "Google Inc",
    "Dribbble Inc",
    "Twitter Inc",
    "Apple Inc",
    "Facebook Inc",
    "Microsoft Inc"
  ];
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
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
                    likes: 12,
                    comments: 10,
                    shares: 2,
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                    height: context.fromHeight(CustomStyle.spaceBetween)),
              )
            : GridView.builder(
                itemCount: connectionimg.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 2 / 2.2,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const JobstopAbouts();
                        },
                      ));
                    },
                    child: ConnectionCard(
                      imageAsset: connectionimg[index].toString(),
                      connectionName: connectionname[index].toString(),
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

class PostWidget extends StatelessWidget {
  final String authorName;
  final String timeAgo;
  final String postTitle;
  final String postContent;
  final int likes;
  final int comments;
  final int shares;

  const PostWidget({
    Key? key,
    required this.authorName,
    required this.timeAgo,
    required this.postTitle,
    required this.postContent,
    required this.likes,
    required this.comments,
    required this.shares,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return RoundedBorderRadiusCardWidget(
      paddingValue: context.fromWidth(CustomStyle.paddingValue),
      paddingType: PaddingType.all,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width / 26,
                vertical: height / 66,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(JobstopPngImg.photo),
                      ),
                      SizedBox(
                        width: width / 46,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authorName,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: height / 150,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                JobstopPngImg.watch,
                                height: height / 56,
                              ),
                              SizedBox(
                                width: width / 46,
                              ),
                              Text(
                                timeAgo,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: height / 46,
                  ),
                  Text(
                    postTitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Jobstopcolor.primarycolor,
                      // Change to your desired color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: height / 96,
                  ),
                  Text(
                    postContent,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey, // Change to your desired color
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
