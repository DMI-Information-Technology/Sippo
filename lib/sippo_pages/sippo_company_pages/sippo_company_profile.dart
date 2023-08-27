import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopprefname.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:get/get.dart';
import 'package:jobspot/sippo_custom_widget/add_info_profile_card.dart';

class SippoCompanyProfile extends StatefulWidget {
  const SippoCompanyProfile({Key? key}) : super(key: key);

  @override
  State<SippoCompanyProfile> createState() => _SippoCompanyProfileState();
}

class _SippoCompanyProfileState extends State<SippoCompanyProfile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderInfoProfile(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width / 26,
                vertical: height / 46,
              ),
              child: Column(
                children: [
                  AddInfoProfileCard(
                    title: "General Information",
                    noInfoProfile: true,
                    leading: Image.asset(
                      JobstopPngImg.aboutme,
                      height: height / 40,
                      color: Jobstopcolor.primarycolor,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                    onAddClicked: () {},
                    profileInfo: [],
                  ),
                  SizedBox(
                    height: height / 46,
                  ),
                  AddInfoProfileCard(
                    title: "Work places",
                    noInfoProfile: true,
                    leading: Image.asset(
                      JobstopPngImg.bag,
                      height: height / 40,
                      color: Jobstopcolor.primarycolor,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                    onAddClicked: () {},
                    profileInfo: [],
                  ),
                  SizedBox(height: height / 46),
                  AddInfoProfileCard(
                    title: "Website",
                    noInfoProfile: true,
                    leading: Image.asset(
                      JobstopPngImg.education,
                      height: height / 40,
                      color: Jobstopcolor.primarycolor,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                    onAddClicked: () {},
                    profileInfo: [],
                  ),
                  SizedBox(height: height / 46),
                  AddInfoProfileCard(
                    title: "Company Special",
                    noInfoProfile: true,
                    leading: Image.asset(
                      JobstopPngImg.skil,
                      height: height / 40,
                      color: Jobstopcolor.primarycolor,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                    iconAction: Icon(
                      Icons.mode_edit_outline_outlined,
                      size: height / 36,
                      color: Jobstopcolor.primarycolor,
                    ),
                    profileInfo: [],
                    onAddClicked: () {},
                  ),
                  SizedBox(height: height / 46),
                  AddInfoProfileCard(
                    title: "Employee NO.",
                    noInfoProfile: true,
                    leading: Image.asset(
                      JobstopPngImg.language,
                      height: height / 40,
                      color: Jobstopcolor.primarycolor,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                    profileInfo: [],
                    onAddClicked: () {},
                  ),
                  SizedBox(
                    height: height / 46,
                  ),
                  AddInfoProfileCard(
                    title: "Foundation Date",
                    noInfoProfile: true,
                    leading: Image.asset(
                      JobstopPngImg.appreciation,
                      height: height / 40,
                      color: Jobstopcolor.primarycolor,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                    profileInfo: [],
                    onAddClicked: () {
                      Get.toNamed(
                        SippoRoutes.appreciationaddedit,
                        arguments: {appreciationArg: null},
                      );
                    },
                  ),
                  SizedBox(height: height / 46),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderInfoProfile() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Jobstopcolor.primarycolor,
        image: DecorationImage(
          image: AssetImage(JobstopPngImg.backgroundProf),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width / 26, vertical: height / 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(JobstopPngImg.photo),
                ),
                SizedBox(
                  width: width / 2,
                ),
                Image.asset(
                  JobstopPngImg.union,
                  height: height / 36,
                  color: Jobstopcolor.white,
                ),
                InkWell(
                  onTap: () =>
                      Get.toNamed(SippoRoutes.sippoprofilesetting),
                  child: Image.asset(
                    JobstopPngImg.setting,
                    height: height / 36,
                    color: Jobstopcolor.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 46,
            ),
            Text(
              "DMI",
              style:
                  dmsmedium.copyWith(fontSize: 14, color: Jobstopcolor.white),
            ),
            SizedBox(
              height: height / 100,
            ),
            Text(
              "Tripoli, Libya",
              style:
                  dmsregular.copyWith(fontSize: 12, color: Jobstopcolor.white),
            ),
            SizedBox(
              height: height / 36,
            ),
            Row(
              children: [
                Spacer(),
                InkWell(
                  onTap: () => Get.toNamed(SippoRoutes.edituserprofile),
                  child: Row(
                    children: [
                      Text(
                        "Edit Details",
                        style: dmsregular.copyWith(
                            fontSize: 12, color: Jobstopcolor.white),
                      ),
                      Image.asset(
                        JobstopPngImg.edit,
                        height: height / 36,
                        color: Jobstopcolor.white,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
