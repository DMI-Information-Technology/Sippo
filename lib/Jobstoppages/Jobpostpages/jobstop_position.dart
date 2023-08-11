import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';

import '../../JobThemes/themecontroller.dart';

class JobstopPosition extends StatefulWidget {
  final String? type;

  const JobstopPosition({super.key, this.type});

  @override
  State<JobstopPosition> createState() => _JobstopPositionState();
}

class _JobstopPositionState extends State<JobstopPosition> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  final themedata = Get.put(JobstopThemecontroler());
  TextEditingController search = TextEditingController();
  List<String> listing = [
    "Assistant",
    "Associate",
    "Administrative Assistant",
    "Account Manager",
    "Assistant Manager",
    "Commission Sales Associate",
    "sales Attendant",
    "Accountant",
    "Sales Advocate",
    "Analyst"
  ];
  List<String> location = [
    "Califon, United States",
    "California, United States",
    "California City, United States"
  ];
  List<String> skillname = [
    "Leadership",
    "Teamwork",
    "Visioner",
    "Target oriented",
    "Consistent",
    "Good communication skills",
    "English",
    "Responsibility"
  ];
  int selectskill = 0;
  int selectlanguage = 0;
  List<String> education = [
    "Bachelor of Electronic Engineering (Indrustrial Electronics)",
    "Bachelor of Information Technology",
    "Economics (Bachelor of Science), Psycology",
    "Bachelor of Arts (Hons) Mass Communication With Public Relations",
    "Bachelor of Science in Computer Science",
    "Bachelors of Science in Marketing",
    "Bachelor of Engineering With A Major in Engineering Product Development (Robotic Track)",
    "Bachelor of Busines (Economics/Finance)",
    "Bachelors of Science in Marketing",
    "Bachelors of Business Adminisitration"
  ];
  List<String> companyname = [
    "Google",
    "Apple",
    "Amazon",
    "Dribbble",
    "Twitter",
    "Facebook",
    "Microsoft",
    "Allianz",
    "Adobe",
    "AXA",
    "Airbuz"
  ];
  List<String> studyname = [
    "Information Technology",
    "Business Information Systems",
    "Computer Information Science",
    "Computer Information Systems",
    "Healt Information Management",
    "History and Information",
    "Information Assurance",
    "Information Security",
    "Information Systems",
    "Information Systems Major"
  ];
  List<String> institutionname = [
    "University of Oxford",
    "National University of Lesotho International School",
    "University of Chester CE Academy",
    "University of Chester Academy Northwich",
    "University of Birmingham School",
    "Bloomsburg University of Pennsylvania",
    "California University of Pennsylvania",
    " ClarionUniversity of Pennsylvania",
    "East Stroundsburg State University of Pennsylvania",
  ];
  List<String> companyimg = [
    JobstopPngImg.google,
    JobstopPngImg.apple,
    JobstopPngImg.amazonlogo,
    JobstopPngImg.dribbblelogo,
    JobstopPngImg.twitterlogo,
    JobstopPngImg.facebooklogo,
    JobstopPngImg.microsoft,
    JobstopPngImg.allianzlogo,
    JobstopPngImg.adobelogo,
    JobstopPngImg.axalogo,
    JobstopPngImg.airbuslogo
  ];
  List<String> languageimg = [
    JobstopPngImg.arabic,
    JobstopPngImg.indonesian,
    JobstopPngImg.malaysian,
    JobstopPngImg.english,
    JobstopPngImg.french,
    JobstopPngImg.german,
    JobstopPngImg.hindi,
    JobstopPngImg.italian,
    JobstopPngImg.japanese,
    JobstopPngImg.korean
  ];
  List<String> languagename = [
    "Arabic",
    "Indonesian",
    "Malaysian",
    "English",
    "French",
    "German",
    "Hindi",
    "Italian",
    "Japanese",
    "Korean"
  ];

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.type == "1") ...[
                Text(
                  "Job Position",
                  style: dmsbold.copyWith(
                      fontSize: 16,
                      color: themedata.isdark
                          ? Jobstopcolor.white
                          : Jobstopcolor.primarycolor),
                ),
              ] else if (widget.type == "2") ...[
                Text(
                  "Location",
                  style: dmsbold.copyWith(
                      fontSize: 16,
                      color: themedata.isdark
                          ? Jobstopcolor.white
                          : Jobstopcolor.primarycolor),
                ),
              ] else if (widget.type == "3") ...[
                Text(
                  "Company",
                  style: dmsbold.copyWith(
                      fontSize: 16,
                      color: themedata.isdark
                          ? Jobstopcolor.white
                          : Jobstopcolor.primarycolor),
                ),
              ] else if (widget.type == "4") ...[
                Text(
                  "Level of Education",
                  style: dmsbold.copyWith(
                      fontSize: 16,
                      color: themedata.isdark
                          ? Jobstopcolor.white
                          : Jobstopcolor.primarycolor),
                ),
              ] else if (widget.type == "5") ...[
                Text(
                  "Institution name",
                  style: dmsbold.copyWith(
                      fontSize: 16,
                      color: themedata.isdark
                          ? Jobstopcolor.white
                          : Jobstopcolor.primarycolor),
                ),
              ] else if (widget.type == "6") ...[
                Text(
                  "Field of study",
                  style: dmsbold.copyWith(
                      fontSize: 16,
                      color: themedata.isdark
                          ? Jobstopcolor.white
                          : Jobstopcolor.primarycolor),
                ),
              ] else if (widget.type == "7") ...[
                Text(
                  "Skill",
                  style: dmsbold.copyWith(
                      fontSize: 16,
                      color: themedata.isdark
                          ? Jobstopcolor.white
                          : Jobstopcolor.primarycolor),
                ),
              ] else if (widget.type == "8") ...[
                Text(
                  "Add Language",
                  style: dmsbold.copyWith(
                      fontSize: 16,
                      color: themedata.isdark
                          ? Jobstopcolor.white
                          : Jobstopcolor.primarycolor),
                ),
              ],
              SizedBox(
                height: height / 36,
              ),
              Container(
                height: height / 18,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Jobstopcolor.white,
                    boxShadow: const [
                      BoxShadow(color: Jobstopcolor.shedo, blurRadius: 5)
                    ]),
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
                      suffixIcon: const Icon(
                        Icons.close,
                        size: 20,
                      ),
                      hintStyle: dmsregular.copyWith(
                          fontSize: 12, color: Jobstopcolor.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      fillColor: Jobstopcolor.white),
                ),
              ),
              SizedBox(
                height: height / 26,
              ),
              if (widget.type == "1") ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listing.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: height / 46),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listing[index].toString(),
                            style: dmsregular.copyWith(
                                fontSize: 12, color: Jobstopcolor.darkgrey),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ] else if (widget.type == "2") ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: location.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: height / 46),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            location[index].toString(),
                            style: dmsregular.copyWith(
                                fontSize: 12, color: Jobstopcolor.darkgrey),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    );
                  },
                )
              ] else if (widget.type == "3") ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: companyname.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: height / 46),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            companyimg[index],
                            height: height / 20,
                          ),
                          SizedBox(
                            width: width / 26,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                companyname[index].toString(),
                                style: dmsregular.copyWith(
                                    fontSize: 12,
                                    color: Jobstopcolor.primarycolor),
                              ),
                              SizedBox(
                                height: height / 200,
                              ),
                              Text(
                                "Company . Internet",
                                style: dmsregular.copyWith(
                                    fontSize: 10, color: Jobstopcolor.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ] else if (widget.type == "4") ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: education.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: height / 46),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            education[index].toString(),
                            style: dmsregular.copyWith(
                                fontSize: 12, color: Jobstopcolor.darkgrey),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    );
                  },
                )
              ] else if (widget.type == "5") ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: institutionname.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: height / 46),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            institutionname[index].toString(),
                            style: dmsregular.copyWith(
                                fontSize: 12, color: Jobstopcolor.darkgrey),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    );
                  },
                )
              ] else if (widget.type == "6") ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: studyname.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: height / 46),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            studyname[index].toString(),
                            style: dmsregular.copyWith(
                                fontSize: 12, color: Jobstopcolor.darkgrey),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    );
                  },
                )
              ] else if (widget.type == "7") ...[
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: skillname.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1 / 0.2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectskill = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: selectskill == index
                                ? Jobstopcolor.orenge
                                : Jobstopcolor.greyyy),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width / 26),
                          child: Row(
                            children: [
                              SizedBox(
                                width: width / 3.5,
                                child: Text(
                                  skillname[index].toString(),
                                  style: dmsregular.copyWith(
                                      fontSize: 12,
                                      color: selectskill == index
                                          ? Jobstopcolor.white
                                          : Jobstopcolor.darkgrey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                width: width / 36,
                              ),
                              Icon(
                                Icons.close,
                                size: 15,
                                color: selectskill == index
                                    ? Jobstopcolor.white
                                    : Jobstopcolor.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              ] else if (widget.type == "8") ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: languageimg.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectlanguage = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: height / 46),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: selectlanguage == index
                                ? Jobstopcolor.lightprimary
                                : Jobstopcolor.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: selectlanguage == index ? 0 : 5,
                                color: Jobstopcolor.greyyy,
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: height / 96, horizontal: width / 26),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundImage: AssetImage(
                                  languageimg[index],
                                ),
                              ),
                              SizedBox(
                                width: width / 26,
                              ),
                              Text(
                                languagename[index].toString(),
                                style: dmsregular.copyWith(
                                    fontSize: 12,
                                    color: Jobstopcolor.primarycolor),
                              ),
                              const Spacer(),
                              if (selectlanguage == index) ...[
                                const Icon(
                                  Icons.check,
                                  size: 20,
                                  color: Jobstopcolor.primarycolor,
                                )
                              ]
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
