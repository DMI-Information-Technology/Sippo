import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';

class JobstopOrder extends StatefulWidget {
  const JobstopOrder({Key? key}) : super(key: key);

  @override
  State<JobstopOrder> createState() => _JobstopOrderState();
}

class _JobstopOrderState extends State<JobstopOrder> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  int selectlist = 0;
  List<String> imagelist = [JobstopPngImg.google,JobstopPngImg.dribbble,JobstopPngImg.twitterlogo];
  List<String> bottomimg = [JobstopPngImg.subtract,JobstopPngImg.union,JobstopPngImg.deleted,JobstopPngImg.applay];
  List<String> bottomname = ["Send message", "Shared","Delete","Apply"];
  List<String> name = ["UI/UX Designer", "Lead Designer","UX Researcher"];
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title:  Text("Save_Job".tr,style: dmsbold.copyWith(fontSize: 20),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Delete all",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.orenge),),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/96),
          child: Column(
            children: [
              // SizedBox(height: height/36,),
              // Text("No Savings",style: dmsbold.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),),
              // SizedBox(height: height/36,),
              // Text("You don't have any jobs saved, please\nfind it in search to save jobs",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),textAlign: TextAlign.center,),
              // SizedBox(height: height/10,),
              // Image.asset(JobstopPngImg.nosavejob,height: height/4,),
              // SizedBox(height: height/8,),
              // Center(
              //   child: Container(
              //     height: height/18,
              //     width: width/1.5,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(5),
              //       color: Jobstopcolor.primarycolor,
              //     ),
              //     child: Center(child: Text("Find a job",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
              //   ),
              // ),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: imagelist.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    highlightColor: Jobstopcolor.transparent,
                    splashColor: Jobstopcolor.transparent,
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return const Specialization();
                      // },));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: height/36),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Jobstopcolor.white,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 5,
                              color: Jobstopcolor.greyyy,
                            )
                          ]
                      ),
                      child:  Padding(
                        padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Jobstopcolor.greyyy,
                                  child: Image.asset(imagelist[index].toString(),height: height/26,),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    _showlist();
                                  },
                                    child: Image.asset(JobstopPngImg.dots,height: height/36,color: Jobstopcolor.black,)),
                              ],
                            ),
                            SizedBox(height: height/66,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name[index].toString(),style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.black),),
                                SizedBox(height: height/150,),
                                Text("Google inc . California, USA",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                              ],
                            ),
                            SizedBox(height: height/46,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: height/28,
                                  width: width/4.2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Jobstopcolor.greyyy
                                  ),
                                  child:  Center(child: Text("Design",style: dmsregular.copyWith(fontSize: 10,color: Jobstopcolor.darkgrey))),),
                                Container(
                                  height: height/28,
                                  width: width/4.2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Jobstopcolor.greyyy
                                  ),
                                  child:  Center(child: Text("Full time",style: dmsregular.copyWith(fontSize: 10,color: Jobstopcolor.darkgrey))),),
                                Container(
                                  height: height/28,
                                  width: width/3.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Jobstopcolor.greyyy
                                  ),
                                  child:  Center(child: Text("Senior designer",style: dmsregular.copyWith(fontSize: 10,color: Jobstopcolor.darkgrey))),),
                              ],
                            ),
                            SizedBox(height: height/46,),
                            Row(
                              children: [
                                Text("25 minute ago",style: dmsregular.copyWith(fontSize: 10,color: Jobstopcolor.grey),),
                                const Spacer(),
                                Text("\$15K",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                                Text("/Mo",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),),
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
      ),
    );
  }
  _showlist() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Jobstopcolor.transparent,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                decoration: const BoxDecoration(
                  color: Jobstopcolor.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                ),
                height: height / 2.5,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 26, vertical: height / 66),
                  child: Column(
                    children: [
                      Container(
                        height: height / 500,
                        width: width / 8,
                        decoration: BoxDecoration(
                          color: Jobstopcolor.primarycolor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      SizedBox(height: height / 15,),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: bottomimg.length,
                        itemBuilder: (context, index) {
                        return  InkWell(
                          splashColor: Jobstopcolor.transparent,
                          highlightColor: Jobstopcolor.transparent,
                          onTap: () {
                            setState(() {
                              selectlist = index;
                            });
                            },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: selectlist == index ? Jobstopcolor.primarycolor : Jobstopcolor.white
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                              child: Row(
                                children: [
                                  Image.asset(bottomimg[index].toString(),height: height/46,color: selectlist == index ? Jobstopcolor.white : Jobstopcolor.primarycolor,),
                                  SizedBox(width: width/36,),
                                  Text(bottomname[index].toString(),style: dmsregular.copyWith(fontSize: 14,color: selectlist == index ? Jobstopcolor.white : Jobstopcolor.primarycolor),)
                                ],
                              ),
                            ),
                          ),
                        );
                      },)
                    ],
                  ),
                ),
              );
            });
      },);
  }
}
