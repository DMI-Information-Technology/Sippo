import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';


import '../sippo_company_pages/company_post_and_jobs/sippo_company_edit_add_jobs.dart';
import '../sippo_company_pages/company_post_and_jobs/sippo_company_edit_add_post.dart';
import 'jobstop_filter.dart';
import 'sippo_user_notification.dart';

class Specialization extends StatefulWidget {
  const Specialization({Key? key}) : super(key: key);

  @override
  State<Specialization> createState() => _SpecializationState();
}

class _SpecializationState extends State<Specialization> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  List<String> image = [
    JobstopPngImg.design,
    JobstopPngImg.finance,
    JobstopPngImg.education,
    JobstopPngImg.restaurant,
    JobstopPngImg.health,
    JobstopPngImg.programmer
  ];
  List<String> name = [
    "Design",
    "Finance",
    "Education",
    "Restaurant",
    "Health",
    "Programmer"
  ];
  TextEditingController search = TextEditingController();
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Jobstopcolor.primarycolor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width / 26, vertical: height / 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hi, Orlando Diggs",
                          style: dmsbold.copyWith(
                              fontSize: 14, color: Jobstopcolor.white),
                        ),
                        SizedBox(
                          width: width / 3,
                        ),
                        Stack(
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const SippoUserJobNotification();
                                    },
                                  ));
                                },
                                child: const Icon(
                                  Icons.notifications_none,
                                  size: 25,
                                  color: Jobstopcolor.white,
                                )),
                            Positioned(
                                top: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 6,
                                  backgroundColor: Jobstopcolor.orenge,
                                  child: Text(
                                    "2",
                                    style: dmsmedium.copyWith(
                                        fontSize: 8, color: Jobstopcolor.white),
                                  ),
                                ))
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            _showbottomsheet();
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(JobstopPngImg.photo),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height / 46,
                    ),
                    Text(
                      "find_your_dream_job".tr,
                      style: dmsbold.copyWith(
                          fontSize: 20, color: Jobstopcolor.white),
                    ),
                    SizedBox(
                      height: height / 46,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: height / 18,
                          width: width / 1.3,
                          child: TextField(
                            controller: search,
                            style: dmsregular.copyWith(
                                fontSize: 12, color: Jobstopcolor.primarycolor),
                            cursorColor: Jobstopcolor.grey,
                            decoration: InputDecoration(
                                filled: true,
                                hintText: "Search".tr,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    JobstopPngImg.search,
                                    height: height / 36,
                                  ),
                                ),
                                hintStyle: dmsregular.copyWith(
                                    fontSize: 12, color: Jobstopcolor.grey),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none),
                                fillColor: Jobstopcolor.white),
                          ),
                        ),
                        InkWell(
                          splashColor: Jobstopcolor.transparent,
                          highlightColor: Jobstopcolor.transparent,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const JobstopFilter();
                              },
                            ));
                          },
                          child: Container(
                            height: height / 18,
                            width: height / 18,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Jobstopcolor.orenge),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(JobstopPngImg.filter),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height / 36,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: height/5,),
                  // Center(child: Image.asset(JobstopPngImg.nofound,height: height/5,)),
                  // SizedBox(height: height/10,),
                  // Center(child: Text("No results found",style: dmsbold.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),)),
                  // SizedBox(height: height/46,),
                  // Center(child: Text("The search could not be found, please check\nspelling or write another word.",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),textAlign: TextAlign.center,)),

                  Text(
                    "Specialization".tr,
                    style: dmsbold.copyWith(fontSize: 16),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: image.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 2 / 2,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        splashColor: Jobstopcolor.transparent,
                        highlightColor: Jobstopcolor.transparent,
                        onTap: () {
                          setState(() {
                            selected = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: selected == index
                                  ? Jobstopcolor.orenge
                                  : Jobstopcolor.white,
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
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: selected == index
                                    ? Jobstopcolor.white
                                    : Jobstopcolor.light,
                                child: Image.asset(
                                  image[index].toString(),
                                  height: height / 26,
                                ),
                              ),
                              SizedBox(
                                height: height / 46,
                              ),
                              Text(
                                name[index].toString(),
                                style: dmsbold.copyWith(
                                    fontSize: 14,
                                    color: selected == index
                                        ? Jobstopcolor.white
                                        : Jobstopcolor.primarycolor),
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "120 Jobs",
                                style: dmsregular.copyWith(
                                    fontSize: 12,
                                    color: selected == index
                                        ? Jobstopcolor.white
                                        : Jobstopcolor.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showbottomsheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Jobstopcolor.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Jobstopcolor.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          ),
          height: height / 2.5,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width / 26, vertical: height / 66),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: height / 500,
                  width: width / 8,
                  decoration: BoxDecoration(
                    color: Jobstopcolor.primarycolor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  height: height / 12,
                ),
                Text(
                  "What would you like to add?",
                  style: dmsbold.copyWith(
                      fontSize: 16, color: Jobstopcolor.primarycolor),
                ),
                SizedBox(
                  height: height / 100,
                ),
                Text(
                  "like_post_your_tips_and_experiences".tr,
                  style: dmsregular.copyWith(
                    fontSize: 12,
                    color: Jobstopcolor.darkgrey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height / 26,
                ),
                InkWell(
                  highlightColor: Jobstopcolor.transparent,
                  splashColor: Jobstopcolor.transparent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return  SippoCompanyEditAddPost();
                      },
                    ));
                  },
                  child: Center(
                    child: Container(
                      height: height / 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Jobstopcolor.primarycolor),
                      child: Center(
                          child: Text(
                        "Post".tr,
                        style: dmsbold.copyWith(
                            fontSize: 14, color: Jobstopcolor.white),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 56,
                ),
                InkWell(
                  highlightColor: Jobstopcolor.transparent,
                  splashColor: Jobstopcolor.transparent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const SippoCompanyEditAddJobs();
                      },
                    ));
                  },
                  child: Center(
                    child: Container(
                      height: height / 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Jobstopcolor.lightprimary),
                      child: Center(
                          child: Text(
                        "make_job".tr,
                        style: dmsbold.copyWith(
                            fontSize: 14, color: Jobstopcolor.white),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
