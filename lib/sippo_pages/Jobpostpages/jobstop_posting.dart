import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 26, vertical: height / 96),
          child: Column(
            children: [
              Container(
                height: height / 3.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Jobstopcolor.white,
                    boxShadow: const [
                      BoxShadow(blurRadius: 5, color: Jobstopcolor.shedo)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: height / 4.1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 26, vertical: height / 66),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      AssetImage(JobstopPngImg.photo),
                                ),
                                SizedBox(
                                  width: width / 46,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Arnold Leonardo",
                                      style: dmsbold.copyWith(
                                          fontSize: 12,
                                          color: Jobstopcolor.black),
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
                                          "21 minuts ago",
                                          style: dmsregular.copyWith(
                                              fontSize: 10,
                                              color: Jobstopcolor.grey),
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
                              "What are the characteristics of a fake job call form?",
                              style: dmsbold.copyWith(
                                  fontSize: 12,
                                  color: Jobstopcolor.primarycolor),
                            ),
                            SizedBox(
                              height: height / 96,
                            ),
                            Text(
                              "Because I always find fake job calls so I'm confused which job to take can you share your knowledge here? thank you",
                              style: dmsregular.copyWith(
                                fontSize: 12,
                                color: Jobstopcolor.darkgrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: height / 15,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Jobstopcolor.primary,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width / 15),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Jobstopcolor.red,
                              size: 20,
                            ),
                            SizedBox(
                              width: width / 96,
                            ),
                            Text(
                              "12",
                              style: dmsregular.copyWith(
                                  fontSize: 10, color: Jobstopcolor.grey),
                            ),
                            SizedBox(
                              width: width / 16,
                            ),
                            Image.asset(
                              JobstopPngImg.message,
                              color: Jobstopcolor.grey,
                              height: height / 46,
                            ),
                            SizedBox(
                              width: width / 96,
                            ),
                            Text(
                              "10",
                              style: dmsregular.copyWith(
                                  fontSize: 10, color: Jobstopcolor.grey),
                            ),
                            SizedBox(
                              width: width / 2.5,
                            ),
                            Image.asset(
                              JobstopPngImg.union,
                              color: Jobstopcolor.grey,
                              height: height / 46,
                            ),
                            SizedBox(
                              width: width / 96,
                            ),
                            Text(
                              "2",
                              style: dmsregular.copyWith(
                                  fontSize: 10, color: Jobstopcolor.grey),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height / 26,
              ),
              SizedBox(
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
                                : Jobstopcolor.lightprimary),
                        child: Center(
                            child: Text(
                          list[index],
                          style: selected == index
                              ? dmsbold.copyWith(
                                  fontSize: 14, color: Jobstopcolor.white)
                              : dmsbold.copyWith(
                                  fontSize: 14,
                                  color: Jobstopcolor.primarycolor),
                        )),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: height / 26,
              ),
              if (selected == 0) ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: height / 36),
                      height: height / 3.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Jobstopcolor.white,
                          boxShadow: const [
                            BoxShadow(blurRadius: 5, color: Jobstopcolor.shedo)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: height / 4.1,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width / 26,
                                  vertical: height / 66),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                            AssetImage(JobstopPngImg.photo),
                                      ),
                                      SizedBox(
                                        width: width / 46,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Arnold Leonardo",
                                            style: dmsbold.copyWith(
                                                fontSize: 12,
                                                color: Jobstopcolor.black),
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
                                                "21 minuts ago",
                                                style: dmsregular.copyWith(
                                                    fontSize: 10,
                                                    color: Jobstopcolor.grey),
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
                                    "What are the characteristics of a fake job call form?",
                                    style: dmsbold.copyWith(
                                        fontSize: 12,
                                        color: Jobstopcolor.primarycolor),
                                  ),
                                  SizedBox(
                                    height: height / 96,
                                  ),
                                  Text(
                                    "Because I always find fake job calls so I'm confused which job to take can you share your knowledge here? thank you",
                                    style: dmsregular.copyWith(
                                        fontSize: 12,
                                        color: Jobstopcolor.darkgrey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: height / 15,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                color: Jobstopcolor.primary),
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: width / 15),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.favorite,
                                    color: Jobstopcolor.red,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: width / 96,
                                  ),
                                  Text(
                                    "12",
                                    style: dmsregular.copyWith(
                                        fontSize: 10, color: Jobstopcolor.grey),
                                  ),
                                  SizedBox(
                                    width: width / 16,
                                  ),
                                  Image.asset(
                                    JobstopPngImg.message,
                                    color: Jobstopcolor.grey,
                                    height: height / 46,
                                  ),
                                  SizedBox(
                                    width: width / 96,
                                  ),
                                  Text(
                                    "10",
                                    style: dmsregular.copyWith(
                                        fontSize: 10, color: Jobstopcolor.grey),
                                  ),
                                  SizedBox(
                                    width: width / 2.5,
                                  ),
                                  Image.asset(
                                    JobstopPngImg.union,
                                    color: Jobstopcolor.grey,
                                    height: height / 46,
                                  ),
                                  SizedBox(
                                    width: width / 96,
                                  ),
                                  Text(
                                    "2",
                                    style: dmsregular.copyWith(
                                        fontSize: 10, color: Jobstopcolor.grey),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )
              ] else ...[
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Jobstopcolor.white,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                color: Jobstopcolor.greyyy,
                              )
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              connectionimg[index].toString(),
                              height: height / 16,
                            ),
                            SizedBox(
                              height: height / 46,
                            ),
                            Text(
                              connectionname[index].toString(),
                              style: dmsbold.copyWith(
                                  fontSize: 14,
                                  color: Jobstopcolor.primarycolor),
                            ),
                            SizedBox(
                              height: height / 100,
                            ),
                            Text(
                              "1M Followers",
                              style: dmsregular.copyWith(
                                  fontSize: 12, color: Jobstopcolor.grey),
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
                                      color: Jobstopcolor.lightprimary)),
                              child: Center(
                                child: Text(
                                  "Follow",
                                  style: dmsregular.copyWith(
                                      fontSize: 12,
                                      color: Jobstopcolor.primarycolor),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
