import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';

import 'job_specialization.dart';

class JobSearch extends StatefulWidget {
  const JobSearch({Key? key}) : super(key: key);

  @override
  State<JobSearch> createState() => _JobSearchState();
}

class _JobSearchState extends State<JobSearch> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  TextEditingController search = TextEditingController();
  TextEditingController loaction = TextEditingController();
  List<String> list = ["Senior designer", "Designer", "Full-time"];
  List<String> imagelist = [JobstopPngImg.google, JobstopPngImg.dribbble];
  List<String> name = ["UI/UX Designer", "Lead Designer"];
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
            // SizedBox(height: height/76,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Jobstopcolor.primarycolor),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width / 26, vertical: height / 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        splashColor: Jobstopcolor.transparent,
                        highlightColor: Jobstopcolor.transparent,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          size: 25,
                          color: Jobstopcolor.white,
                        )),
                    SizedBox(
                      height: height / 46,
                    ),
                    TextField(
                      controller: search,
                      style: dmsregular.copyWith(
                          fontSize: 12, color: Jobstopcolor.primarycolor),
                      cursorColor: Jobstopcolor.grey,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: "Design".tr,
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
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          fillColor: Jobstopcolor.white),
                    ),
                    SizedBox(
                      height: height / 46,
                    ),
                    TextField(
                      controller: loaction,
                      style: dmsregular.copyWith(
                          fontSize: 12, color: Jobstopcolor.primarycolor),
                      cursorColor: Jobstopcolor.grey,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: "California, USA".tr,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              JobstopPngImg.location,
                              height: height / 36,
                            ),
                          ),
                          hintStyle: dmsregular.copyWith(
                              fontSize: 12, color: Jobstopcolor.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          fillColor: Jobstopcolor.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height / 36,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 36),
                  child: Container(
                    height: height / 18,
                    width: height / 18,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Jobstopcolor.primarycolor),
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
                      return InkWell(
                        highlightColor: Jobstopcolor.transparent,
                        splashColor: Jobstopcolor.transparent,
                        onTap: () {
                          setState(() {
                            selected = index;
                          });
                        },
                        child: Container(
                          width: width / 3.4,
                          margin: EdgeInsets.only(right: width / 36),
                          decoration: BoxDecoration(
                              color: selected == index
                                  ? Jobstopcolor.primarycolor
                                  : Jobstopcolor.greyyy,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(list[index],
                                  style: dmsregular.copyWith(
                                      fontSize: 12,
                                      color: selected == index
                                          ? Jobstopcolor.white
                                          : Jobstopcolor.darkgrey))),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: imagelist.length,
              itemBuilder: (context, index) {
                return InkWell(
                  highlightColor: Jobstopcolor.transparent,
                  splashColor: Jobstopcolor.transparent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const Specialization();
                      },
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: height / 36,
                        right: width / 26,
                        left: width / 26),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Jobstopcolor.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 5,
                            color: Jobstopcolor.greyyy,
                          )
                        ]),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 26, vertical: height / 46),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: Jobstopcolor.greyyy,
                                child: Image.asset(
                                  imagelist[index].toString(),
                                  height: height / 36,
                                ),
                              ),
                              const Spacer(),
                              Image.asset(
                                JobstopPngImg.order,
                                height: height / 36,
                                color: Jobstopcolor.grey,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 66,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name[index].toString(),
                                style: dmsbold.copyWith(
                                    fontSize: 14, color: Jobstopcolor.black),
                              ),
                              SizedBox(
                                height: height / 150,
                              ),
                              Text(
                                "Google inc . California, USA",
                                style: dmsregular.copyWith(
                                    fontSize: 12, color: Jobstopcolor.darkgrey),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 46,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: height / 28,
                                width: width / 4.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Jobstopcolor.greyyy),
                                child: Center(
                                    child: Text("Design",
                                        style: dmsregular.copyWith(
                                            fontSize: 10,
                                            color: Jobstopcolor.darkgrey))),
                              ),
                              Container(
                                height: height / 28,
                                width: width / 4.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Jobstopcolor.greyyy),
                                child: Center(
                                    child: Text("Full time",
                                        style: dmsregular.copyWith(
                                            fontSize: 10,
                                            color: Jobstopcolor.darkgrey))),
                              ),
                              Container(
                                height: height / 28,
                                width: width / 3.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Jobstopcolor.greyyy),
                                child: Center(
                                    child: Text("Senior designer",
                                        style: dmsregular.copyWith(
                                            fontSize: 10,
                                            color: Jobstopcolor.darkgrey))),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 46,
                          ),
                          Row(
                            children: [
                              Text(
                                "25 minute ago",
                                style: dmsregular.copyWith(
                                    fontSize: 10, color: Jobstopcolor.grey),
                              ),
                              const Spacer(),
                              Text(
                                "\$15K",
                                style: dmsbold.copyWith(
                                    fontSize: 14,
                                    color: Jobstopcolor.primarycolor),
                              ),
                              Text(
                                "/Mo",
                                style: dmsregular.copyWith(
                                    fontSize: 12, color: Jobstopcolor.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
