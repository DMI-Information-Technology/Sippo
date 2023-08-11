import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopprefname.dart';
import 'package:jobspot/JopCustomWidget/widgets.dart';
import 'package:jobspot/Jopstobdata/model/profile_model/jobstop_appreciation_info_card_model.dart';
import '../../JobThemes/themecontroller.dart';

class JobAppreciationAddEdit extends StatefulWidget {
  const JobAppreciationAddEdit({Key? key}) : super(key: key);

  @override
  State<JobAppreciationAddEdit> createState() => _JobAppreciationAddEditState();
}

class _JobAppreciationAddEditState extends State<JobAppreciationAddEdit> {
  bool check = true;
  final themedata = Get.put(JobstopThemecontroler());
  TextEditingController awardCon = TextEditingController();
  TextEditingController categoryAchieveCon = TextEditingController();
  TextEditingController endDateCon = TextEditingController();
  TextEditingController description = TextEditingController();
  AppreciationInfoCardModel? appreci;

  @override
  void initState() {
    appreci =
        AppreciationInfoCardModel.fromJson(Get.arguments[appreciationArg]);
    awardCon.text = appreci?.awardName ?? "";
    categoryAchieveCon.text = appreci?.categoryAchieve ?? "";
    endDateCon.text = appreci?.year ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 26, vertical: height / 96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit Appreciation",
                style: dmsbold.copyWith(
                    fontSize: 16,
                    color: themedata.isdark
                        ? Jobstopcolor.white
                        : Jobstopcolor.primarycolor),
              ),
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
              InputBorderedField(
                height: height / 12.5,
                fontSize: height / 68,
                controller: awardCon,
              ),
              SizedBox(
                height: height / 36,
              ),
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
              InputBorderedField(
                height: height / 12.5,
                fontSize: height / 68,
                controller: categoryAchieveCon,
              ),
              SizedBox(
                height: height / 66,
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
                  InputBorderedField(
                    height: height / 12.5,
                    fontSize: height / 68,
                    width: width / 2.3,
                    controller: endDateCon,
                  ),
                ],
              ),
              SizedBox(
                height: height / 36,
              ),
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
                            BoxShadow(color: Jobstopcolor.shedo, blurRadius: 5)
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
              InputBorderedField(
                controller: description,
                height: height / 5,
                hintText: "Write additional information here",
                hintStyle: dmsregular.copyWith(
                  fontSize: 12,
                  color: Jobstopcolor.grey,
                ),
                keyboardType: TextInputType.multiline,
                maxLine: 5,
              ),
              SizedBox(
                height: height / 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width / 2.3,
                    child: CustomButton(
                      onTappeed: () {
                        _showremove();
                      },
                      text: "REMOVE".tr,
                      backgroundColor: Jobstopcolor.lightprimary,
                    ),
                  ),
                  SizedBox(
                    width: width / 2.3,
                    child: CustomButton(
                      onTappeed: () {
                        _showundo();
                      },
                      text: "SAVE".tr,
                      backgroundColor: Jobstopcolor.primarycolor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      backgroundColor: Jobstopcolor.backgroudHome,
    );
  }

  _showundo() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    Get.bottomSheet(
      isScrollControlled: true,
      Container(
        height: height * 0.4,
        decoration: const BoxDecoration(
          color: Jobstopcolor.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        ),
        child: SingleChildScrollView(
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
                CustomButton(
                  onTappeed: () {},
                  text: "Continue Filling".tr,
                ),
                SizedBox(
                  height: height / 56,
                ),
                CustomButton(
                  onTappeed: () {},
                  text: "Undo Changes",
                  backgroundColor: Jobstopcolor.lightprimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showremove() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
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
          height: height * 0.4,
          child: SingleChildScrollView(
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
                    "Remove Appreciation ?",
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
                  CustomButton(
                    onTappeed: () {},
                    text: "Continue Filling".tr,
                  ),
                  SizedBox(
                    height: height / 56,
                  ),
                  CustomButton(
                    onTappeed: () {},
                    text: "Undo Changes",
                    backgroundColor: Jobstopcolor.lightprimary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

