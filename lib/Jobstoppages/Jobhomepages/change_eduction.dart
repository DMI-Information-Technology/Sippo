import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import '../../JobThemes/themecontroller.dart';
import '../../JopCustomWidget/SearchDelegteImpl.dart';
import '../Jobpostpages/jobstop_position.dart';

class ChangeEducation extends StatefulWidget {
  final String? type;

  const ChangeEducation({super.key, this.type});

  @override
  State<ChangeEducation> createState() => _ChangeEducationState();
}

class _ChangeEducationState extends State<ChangeEducation> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  bool check = true;
  final themedata = Get.put(JobstopThemecontroler());
  TextEditingController description = TextEditingController();
  TextEditingController awardname = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController date = TextEditingController();
  final data = [
    "education 1",
    "education 2",
    "education 3",
    "education 4",
    "education 5",
    "education 6",
    "education 7",
  ];

  datedialog(String type) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Jobstopcolor.transparent,
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                color:
                    themedata.isdark ? Jobstopcolor.black : Jobstopcolor.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width / 26, vertical: height / 36),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: height / 500,
                      width: width / 8,
                      decoration: BoxDecoration(
                        color: themedata.isdark
                            ? Jobstopcolor.white
                            : Jobstopcolor.primarycolor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      height: height / 36,
                    ),
                    if (type == "1") ...[
                      Text(
                        "Start date",
                        style: dmsbold.copyWith(
                            fontSize: 16,
                            color: themedata.isdark
                                ? Jobstopcolor.white
                                : Jobstopcolor.primarycolor),
                      ),
                    ] else ...[
                      Text(
                        "End date",
                        style: dmsbold.copyWith(
                            fontSize: 16,
                            color: themedata.isdark
                                ? Jobstopcolor.white
                                : Jobstopcolor.primarycolor),
                      ),
                    ],
                    Image.asset(
                      JobstopPngImg.enddateimg,
                      height: height / 3,
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.pop(context);
                      },
                      child: Center(
                        child: Container(
                          height: height / 18,
                          width: width / 1.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Jobstopcolor.primarycolor),
                          child: Center(
                              child: Text("SAVE",
                                  style: dmsbold.copyWith(
                                      fontSize: 14,
                                      color: Jobstopcolor.white))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 46,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Container(
                          height: height / 18,
                          width: width / 1.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Jobstopcolor.lightprimary),
                          child: Center(
                              child: Text("CANCEL",
                                  style: dmsbold.copyWith(
                                      fontSize: 14,
                                      color: Jobstopcolor.white))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

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
                  "Change Education",
                  style: dmsbold.copyWith(
                      fontSize: 16,
                      color: themedata.isdark
                          ? Jobstopcolor.white
                          : Jobstopcolor.primarycolor),
                ),
              ] else ...[
                Text(
                  "Edit Appreciation",
                  style: dmsbold.copyWith(
                      fontSize: 16,
                      color: themedata.isdark
                          ? Jobstopcolor.white
                          : Jobstopcolor.primarycolor),
                ),
              ],
              if (widget.type == "1") ...[
                SizedBox(
                  height: height / 36,
                ),
                Text(
                  "Level of education",
                  style: dmsbold.copyWith(
                      fontSize: 12,
                      color: themedata.isdark
                          ? Jobstopcolor.white
                          : Jobstopcolor.primarycolor),
                ),
                SizedBox(
                  height: height / 66,
                ),
                InkWell(
                  onTap: () {

                    showSearch(
                      context: context,
                      delegate: MySearchDelegate(
                        hintText: "search on level of education",
                        textFieldStyle: TextStyle(fontSize: height / 58),
                        pageTitle: "Level of education",
                        suggestions: data,
                        onSelectedSearch: (String) {},
                        buildResultSearch: (context, i, value) {
                          return ListTile(title: Text(value));
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: width / 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Jobstopcolor.white,
                      boxShadow: const [
                        BoxShadow(color: Jobstopcolor.shedo, blurRadius: 5)
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width / 26,
                        vertical: height / 66,
                      ),
                      child: Text(
                        "Bachelor of Information Technology",
                        style: dmsregular.copyWith(
                          fontSize: 12,
                          color: Jobstopcolor.darkgrey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 36,
                ),
              ] else ...[
                SizedBox(
                  height: height / 36,
                ),
                Text(
                  "Award name",
                  style: dmsbold.copyWith(
                      fontSize: 12,
                      color: themedata.isdark
                          ? Jobstopcolor.white
                          : Jobstopcolor.primarycolor),
                ),
                SizedBox(
                  height: height / 66,
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
                    controller: awardname,
                    style: dmsregular.copyWith(
                        fontSize: 12, color: Jobstopcolor.primarycolor),
                    cursorColor: Jobstopcolor.grey,
                    decoration: InputDecoration(
                        filled: true,
                        hintText: "Wireless Symposium (RWS)",
                        hintStyle: dmsregular.copyWith(
                            fontSize: 12, color: Jobstopcolor.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        fillColor: Jobstopcolor.white),
                  ),
                ),
                SizedBox(
                  height: height / 36,
                ),
              ],
              if (widget.type == "1") ...[
                Text(
                  "Institution name",
                  style: dmsbold.copyWith(
                      fontSize: 12,
                      color: themedata.isdark
                          ? Jobstopcolor.white
                          : Jobstopcolor.primarycolor),
                ),
                SizedBox(
                  height: height / 66,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const JobstopPosition(type: "5");
                      },
                    ));
                  },
                  child: Container(
                      width: width / 1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Jobstopcolor.white,
                          boxShadow: const [
                            BoxShadow(color: Jobstopcolor.shedo, blurRadius: 5)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 26, vertical: height / 66),
                        child: Text(
                          "University of Oxford",
                          style: dmsregular.copyWith(
                              fontSize: 12, color: Jobstopcolor.darkgrey),
                        ),
                      )),
                ),
                SizedBox(
                  height: height / 36,
                ),
              ] else ...[
                Text(
                  "Category/Achievement achieved",
                  style: dmsbold.copyWith(
                      fontSize: 12,
                      color: themedata.isdark
                          ? Jobstopcolor.white
                          : Jobstopcolor.primarycolor),
                ),
                SizedBox(
                  height: height / 66,
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
                    controller: category,
                    style: dmsregular.copyWith(
                        fontSize: 12, color: Jobstopcolor.primarycolor),
                    cursorColor: Jobstopcolor.grey,
                    decoration: InputDecoration(
                        filled: true,
                        hintText: "Young Scientist",
                        hintStyle: dmsregular.copyWith(
                            fontSize: 12, color: Jobstopcolor.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        fillColor: Jobstopcolor.white),
                  ),
                ),
                SizedBox(
                  height: height / 36,
                ),
              ],
              if (widget.type == "1") ...[
                Text(
                  "Field of study",
                  style: dmsbold.copyWith(
                      fontSize: 12,
                      color: themedata.isdark
                          ? Jobstopcolor.white
                          : Jobstopcolor.primarycolor),
                ),
                SizedBox(
                  height: height / 66,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const JobstopPosition(type: "6");
                      },
                    ));
                  },
                  child: Container(
                      width: width / 1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Jobstopcolor.white,
                          boxShadow: const [
                            BoxShadow(color: Jobstopcolor.shedo, blurRadius: 5)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 26, vertical: height / 66),
                        child: Text(
                          "Information Technology",
                          style: dmsregular.copyWith(
                              fontSize: 12, color: Jobstopcolor.darkgrey),
                        ),
                      )),
                ),
                SizedBox(
                  height: height / 36,
                ),
              ],
              if (widget.type == "1") ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start date",
                          style: dmsbold.copyWith(
                              fontSize: 12,
                              color: themedata.isdark
                                  ? Jobstopcolor.white
                                  : Jobstopcolor.primarycolor),
                        ),
                        SizedBox(
                          height: height / 66,
                        ),
                        InkWell(
                          onTap: () {
                            datedialog("1");
                          },
                          child: Container(
                              height: height / 18,
                              width: width / 2.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Jobstopcolor.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Jobstopcolor.shedo,
                                        blurRadius: 5)
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width / 26,
                                    vertical: height / 66),
                                child: Text(
                                  "Sep 2010",
                                  style: dmsregular.copyWith(
                                      fontSize: 12,
                                      color: Jobstopcolor.darkgrey),
                                ),
                              )),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "End date",
                          style: dmsbold.copyWith(
                              fontSize: 12,
                              color: themedata.isdark
                                  ? Jobstopcolor.white
                                  : Jobstopcolor.primarycolor),
                        ),
                        SizedBox(
                          height: height / 66,
                        ),
                        InkWell(
                          onTap: () {
                            datedialog("2");
                          },
                          child: Container(
                              height: height / 18,
                              width: width / 2.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Jobstopcolor.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Jobstopcolor.shedo,
                                        blurRadius: 5)
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width / 26,
                                    vertical: height / 66),
                                child: Text(
                                  "Aug 2013",
                                  style: dmsregular.copyWith(
                                      fontSize: 12,
                                      color: Jobstopcolor.darkgrey),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 36,
                ),
              ] else ...[
                Text(
                  "End date",
                  style: dmsbold.copyWith(
                      fontSize: 12,
                      color: themedata.isdark
                          ? Jobstopcolor.white
                          : Jobstopcolor.primarycolor),
                ),
                SizedBox(
                  height: height / 66,
                ),
                Container(
                  height: height / 18,
                  width: width / 2.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Jobstopcolor.white,
                      boxShadow: const [
                        BoxShadow(color: Jobstopcolor.shedo, blurRadius: 5)
                      ]),
                  child: TextField(
                    controller: date,
                    style: dmsregular.copyWith(
                        fontSize: 12, color: Jobstopcolor.primarycolor),
                    cursorColor: Jobstopcolor.grey,
                    decoration: InputDecoration(
                        filled: true,
                        hintText: "2014",
                        hintStyle: dmsregular.copyWith(
                            fontSize: 12, color: Jobstopcolor.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        fillColor: Jobstopcolor.white),
                  ),
                ),
                SizedBox(
                  height: height / 36,
                ),
              ],
              if (widget.type == "1") ...[
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          check == false ? check = true : check = false;
                        });
                      },
                      child: Container(
                        height: height / 30,
                        width: height / 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Jobstopcolor.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Jobstopcolor.shedo, blurRadius: 5)
                            ]),
                        child: Icon(Icons.check,
                            size: 15,
                            color: check == true
                                ? Jobstopcolor.primarycolor
                                : Jobstopcolor.transparent),
                      ),
                    ),
                    SizedBox(
                      width: width / 16,
                    ),
                    Text(
                      "This is my position now",
                      style: dmsregular.copyWith(
                          fontSize: 12, color: Jobstopcolor.darkgrey),
                    )
                  ],
                ),
                SizedBox(
                  height: height / 36,
                ),
              ],
              Text(
                "Description",
                style: dmsbold.copyWith(
                    fontSize: 12,
                    color: themedata.isdark
                        ? Jobstopcolor.white
                        : Jobstopcolor.primarycolor),
              ),
              SizedBox(
                height: height / 66,
              ),
              Container(
                height: height / 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Jobstopcolor.white,
                    boxShadow: const [
                      BoxShadow(color: Jobstopcolor.shedo, blurRadius: 5)
                    ]),
                child: TextField(
                  controller: description,
                  style: dmsregular.copyWith(
                      fontSize: 12, color: Jobstopcolor.primarycolor),
                  cursorColor: Jobstopcolor.grey,
                  maxLines: 5,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Write additional information here",
                      hintStyle: dmsregular.copyWith(
                          fontSize: 12, color: Jobstopcolor.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      fillColor: Jobstopcolor.white),
                ),
              ),
              SizedBox(
                height: height / 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    highlightColor: Jobstopcolor.transparent,
                    splashColor: Jobstopcolor.transparent,
                    onTap: () {
                      _showremove();
                    },
                    child: Center(
                      child: Container(
                        height: height / 15,
                        width: width / 2.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Jobstopcolor.lightprimary),
                        child: Center(
                            child: Text(
                          "REMOVE".tr,
                          style: dmsbold.copyWith(
                              fontSize: 14, color: Jobstopcolor.white),
                        )),
                      ),
                    ),
                  ),
                  InkWell(
                    highlightColor: Jobstopcolor.transparent,
                    splashColor: Jobstopcolor.transparent,
                    onTap: () {
                      _showundo();
                    },
                    child: Center(
                      child: Container(
                        height: height / 15,
                        width: width / 2.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Jobstopcolor.primarycolor),
                        child: Center(
                            child: Text(
                          "SAVE".tr,
                          style: dmsbold.copyWith(
                              fontSize: 14, color: Jobstopcolor.white),
                        )),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _showundo() {
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
          height: height / 3,
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
                  height: height / 26,
                ),
                Text(
                  "Undo Changes ?",
                  style: dmsbold.copyWith(
                      fontSize: 16, color: Jobstopcolor.primarycolor),
                ),
                SizedBox(
                  height: height / 100,
                ),
                Text(
                  "Are you sure you want to change what you entered?",
                  style: dmsregular.copyWith(
                      fontSize: 12, color: Jobstopcolor.darkgrey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height / 26,
                ),
                InkWell(
                  highlightColor: Jobstopcolor.transparent,
                  splashColor: Jobstopcolor.transparent,
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return const JobAddPost();
                    // },));
                  },
                  child: Center(
                    child: Container(
                      height: height / 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Jobstopcolor.primarycolor),
                      child: Center(
                          child: Text(
                        "Continue Filling".tr,
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
                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return const JobstopAddjob();
                    // },));
                  },
                  child: Center(
                    child: Container(
                      height: height / 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Jobstopcolor.lightprimary),
                      child: Center(
                          child: Text(
                        "Undo Changes".tr,
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

  _showremove() {
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
          height: height / 3,
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
                  height: height / 26,
                ),
                Text(
                  "Remove Education ?",
                  style: dmsbold.copyWith(
                      fontSize: 16, color: Jobstopcolor.primarycolor),
                ),
                SizedBox(
                  height: height / 100,
                ),
                Text(
                  "Are you sure you want to change what you entered?",
                  style: dmsregular.copyWith(
                      fontSize: 12, color: Jobstopcolor.darkgrey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height / 26,
                ),
                InkWell(
                  highlightColor: Jobstopcolor.transparent,
                  splashColor: Jobstopcolor.transparent,
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return const JobAddPost();
                    // },));
                  },
                  child: Center(
                    child: Container(
                      height: height / 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Jobstopcolor.primarycolor),
                      child: Center(
                          child: Text(
                        "Continue Filling".tr,
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
                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return const JobstopAddjob();
                    // },));
                  },
                  child: Center(
                    child: Container(
                      height: height / 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Jobstopcolor.lightprimary),
                      child: Center(
                          child: Text(
                        "Undo Changes".tr,
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
