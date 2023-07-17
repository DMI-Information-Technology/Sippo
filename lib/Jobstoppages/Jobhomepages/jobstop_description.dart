import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';

import '../../JobThemes/themecontroller.dart';
import 'jovstop_uploadcv.dart';

class JobDescription extends StatefulWidget {
  const JobDescription({Key? key}) : super(key: key);

  @override
  State<JobDescription> createState() => _JobDescriptionState();
}

class _JobDescriptionState extends State<JobDescription> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  final themedata = Get.put(JobstopThemecontroler());
  List<String> list = ["Description", "Company"];
  List<String> gallery = [JobstopPngImg.gallery1,JobstopPngImg.gallery2];
  int selected = 0;
  TextEditingController position = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController jobType = TextEditingController();
  TextEditingController specialization = TextEditingController();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height/26,),
            Stack(
              children: [
                Container(
                  height: height/4.5,
                  color: themedata.isdark ? Jobstopcolor.black : Jobstopcolor.backgroud,
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                  height: height/7,
                  width: width/1,
                  color: Jobstopcolor.greyyy,
                  child: Column(
                    children: [
                      SizedBox(height: height/22,),
                      Text("UI/UX Designer",style: dmsbold.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),),
                      SizedBox(height: height/66,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width/20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Google",style: dmsregular.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),),
                            Image.asset(JobstopPngImg.dot,height: height/96,),
                            Text("California",style: dmsregular.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),),
                            Image.asset(JobstopPngImg.dot,height: height/96,),
                            Text("1 day ago",style: dmsregular.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),),
                          ],
                        ),
                      )
                    ],
                  ),
                ),),
                Positioned(
                    top: 0,
                    left: 30,
                    right: 30,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Jobstopcolor.sky,
                      child: Image.asset(JobstopPngImg.google,height: height/14,),
                    )),
              ],
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/96),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              color: selected == index ? Jobstopcolor.primarycolor : Jobstopcolor.lightprimary
                            ),
                            child: Center(
                                child: Text(
                                  list[index],
                                  style: selected == index
                                      ? dmsbold.copyWith(
                                      fontSize: 14,
                                      color: Jobstopcolor.white)
                                      : dmsbold.copyWith(
                                      fontSize: 14,
                                      color: Jobstopcolor.primarycolor),
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: height/46,),
                  if(selected == 0) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Salary",style: dmsregular.copyWith(fontSize: 14,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                        Text("Job Type",style: dmsregular.copyWith(fontSize: 14,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                        Text("Postion",style: dmsregular.copyWith(fontSize: 14,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                      ],
                    ),
                    SizedBox(height: height/40,),
                    Text("Job_Description".tr,style: dmsbold.copyWith(fontSize: 14),),
                    SizedBox(height: height/76,),
                    Text("Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem ...".tr,
                      style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),maxLines: 5,overflow: TextOverflow.ellipsis,),
                    SizedBox(height: height/76,),
                    Container(
                      height: height/28,
                      width: width/3.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Jobstopcolor.lightprimary
                      ),
                      child:  Center(child: Text("Read more",style: dmsmedium.copyWith(fontSize: 13,color: Jobstopcolor.black))),),
                    SizedBox(height: height/36,),
                    Text("Requirements".tr,style: dmsbold.copyWith(fontSize: 14),),
                    SizedBox(height: height/66,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(JobstopPngImg.dot,height: height/120,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor,),
                        SizedBox(
                          width: width/1.15,
                          child: Text("Sed ut perspiciatis unde omnis iste natus error sit.".tr,
                              style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),maxLines: 5,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start),
                        ),
                      ],
                    ),
                    SizedBox(height: height/66,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(JobstopPngImg.dot,height: height/120,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor,),
                        SizedBox(
                          width: width/1.15,
                          child: Text("Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur & adipisci velit.".tr,
                            style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),maxLines: 5,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,),
                        ),
                      ],
                    ),
                    SizedBox(height: height/66,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(JobstopPngImg.dot,height: height/120,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor,),
                        SizedBox(
                          width: width/1.15,
                          child: Text("Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.".tr,
                            style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),maxLines: 5,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,),
                        ),
                      ],
                    ),
                    SizedBox(height: height/66,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(JobstopPngImg.dot,height: height/120,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor,),
                        SizedBox(
                          width: width/1.15,
                          child: Text("Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur".tr,
                            style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),maxLines: 5,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,),
                        ),
                      ],
                    ),
                    SizedBox(height: height/36,),
                    Text("Location".tr,style: dmsbold.copyWith(fontSize: 14),),
                    SizedBox(height: height/66,),
                    Text("Overlook Avenue, Belleville, NJ, USA".tr,style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                    SizedBox(height: height/66,),
                    Container(
                      height: height/5,width: width/1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.asset(JobstopPngImg.locationmap,fit: BoxFit.fill,),
                    ),
                    SizedBox(height: height/36,),
                    Text("Informations".tr,style: dmsbold.copyWith(fontSize: 14),),
                    SizedBox(height: height/46,),
                    Text("Position".tr,style: dmsbold.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                    SizedBox(
                      height: height/22,
                      child: TextField(
                        controller:position,
                        style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                        cursorColor: Jobstopcolor.grey,
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "Position".tr,
                            hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                            fillColor: Jobstopcolor.white),
                      ),
                    ),
                    SizedBox(height: height/46,),
                    Text("Qualification".tr,style: dmsbold.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                    SizedBox(
                      height: height/22,
                      child: TextField(
                        controller:qualification,
                        style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                        cursorColor: Jobstopcolor.grey,
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "Qualification".tr,
                            hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                            fillColor: Jobstopcolor.white),
                      ),
                    ),
                    SizedBox(height: height/46,),
                    Text("Experience".tr,style: dmsbold.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                    SizedBox(
                      height: height/22,
                      child: TextField(
                        controller:experience,
                        style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                        cursorColor: Jobstopcolor.grey,
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "Experience".tr,
                            hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                            fillColor: Jobstopcolor.white),
                      ),
                    ),
                    SizedBox(height: height/46,),
                    Text("Job_Type".tr,style: dmsbold.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                    SizedBox(
                      height: height/22,
                      child: TextField(
                        controller:jobType,
                        style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                        cursorColor: Jobstopcolor.grey,
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "Job_Type".tr,
                            hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                            fillColor: Jobstopcolor.white),
                      ),
                    ),
                    SizedBox(height: height/46,),
                    Text("Specialization".tr,style: dmsbold.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                    SizedBox(
                      height: height/22,
                      child: TextField(
                        controller:specialization,
                        style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                        cursorColor: Jobstopcolor.grey,
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "Specialization".tr,
                            hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                            fillColor: Jobstopcolor.white),
                      ),
                    ),
                    SizedBox(height: height/26,),
                    Text("Facilities_and_Others".tr,style: dmsbold.copyWith(fontSize: 14,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                    SizedBox(height: height/46,),
                    Row(
                      children: [
                        Image.asset(JobstopPngImg.dot,height: height/120,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor,),
                        SizedBox(width: width/36,),
                        Text("Medical".tr,
                            style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),overflow: TextOverflow.ellipsis,textAlign: TextAlign.start),
                      ],
                    ),
                    SizedBox(height: height/66,),
                    Row(
                      children: [
                        Image.asset(JobstopPngImg.dot,height: height/120,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor,),
                        SizedBox(width: width/36,),
                        Text("Dental".tr,
                            style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),overflow: TextOverflow.ellipsis,textAlign: TextAlign.start),
                      ],
                    ),
                    SizedBox(height: height/66,),
                    Row(
                      children: [
                        Image.asset(JobstopPngImg.dot,height: height/120,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor,),
                        SizedBox(width: width/36,),
                        Text("Technical Cartification".tr,
                            style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),overflow: TextOverflow.ellipsis,textAlign: TextAlign.start),
                      ],
                    ),
                    SizedBox(height: height/66,),
                    Row(
                      children: [
                        Image.asset(JobstopPngImg.dot,height: height/120,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor,),
                        SizedBox(width: width/36,),
                        Text("Meal Allowance".tr,
                            style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),overflow: TextOverflow.ellipsis,textAlign: TextAlign.start),
                      ],
                    ),
                    SizedBox(height: height/66,),
                    Row(
                      children: [
                        Image.asset(JobstopPngImg.dot,height: height/120,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor,),
                        SizedBox(width: width/36,),
                        Text("Transport Allowance".tr,
                            style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),overflow: TextOverflow.ellipsis,textAlign: TextAlign.start),
                      ],
                    ),
                    SizedBox(height: height/66,),
                    Row(
                      children: [
                        Image.asset(JobstopPngImg.dot,height: height/120,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor,),
                        SizedBox(width: width/36,),
                        Text("Regular Hours".tr,
                            style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),overflow: TextOverflow.ellipsis,textAlign: TextAlign.start),
                      ],
                    ),
                    SizedBox(height: height/66,),
                    Row(
                      children: [
                        Image.asset(JobstopPngImg.dot,height: height/120,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor,),
                        SizedBox(width: width/36,),
                        Text("Mondays-Fridays".tr,
                            style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),overflow: TextOverflow.ellipsis,textAlign: TextAlign.start),
                      ],
                    ),
                    SizedBox(height: height/16,),
                    InkWell(
                      highlightColor: Jobstopcolor.transparent,
                      splashColor: Jobstopcolor.transparent,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return const Jobuploadcv();
                        },));
                      },
                      child: Center(
                        child: Container(
                          height: height/15,
                          width: width/1.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Jobstopcolor.primarycolor
                          ),
                          child:
                          Center(child: Text("Apply Now".tr,style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
                        ),
                      ),
                    ),
                  ]else ...[
                    Text("About_Company".tr,style: dmsbold.copyWith(fontSize: 14),),
                    SizedBox(height: height/76,),
                    Text("Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.\n\nAt vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas .\n\nNor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain.".tr,
                      style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),maxLines: 15,overflow: TextOverflow.ellipsis,),
                    SizedBox(height: height/36,),
                    Text("Website".tr,style: dmsbold.copyWith(fontSize: 14),),
                    SizedBox(height: height/120,),
                    Text("https://www.google.com".tr,style: dmsbold.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.grey : Jobstopcolor.primarycolor),),
                    SizedBox(height: height/46,),
                    Text("Industry".tr,style: dmsbold.copyWith(fontSize: 14),overflow: TextOverflow.ellipsis),
                    SizedBox(height: height/120,),
                    Text("Internet product".tr,style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                    SizedBox(height: height/46,),
                    Text("Employee_size".tr,style: dmsbold.copyWith(fontSize: 14),overflow: TextOverflow.ellipsis),
                    SizedBox(height: height/120,),
                    Text("132,121 Employees".tr,style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                    SizedBox(height: height/46,),
                    Text("Head_office".tr,style: dmsbold.copyWith(fontSize: 14),overflow: TextOverflow.ellipsis),
                    SizedBox(height: height/120,),
                    Text("Mountain View, California, Amerika Serikat".tr,style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),overflow: TextOverflow.ellipsis,),
                    SizedBox(height: height/46,),
                    Text("Type".tr,style: dmsbold.copyWith(fontSize: 14),),
                    SizedBox(height: height/120,),
                    Text("Multinational company".tr,style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),overflow: TextOverflow.ellipsis,),
                    SizedBox(height: height/46,),
                    Text("Since".tr,style: dmsbold.copyWith(fontSize: 14),),
                    SizedBox(height: height/120,),
                    Text("1998".tr,style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),overflow: TextOverflow.ellipsis,),
                    SizedBox(height: height/46,),
                    Text("Specialization".tr,style: dmsbold.copyWith(fontSize: 14),),
                    SizedBox(height: height/120,),
                    Text("Search technology, Web computing, Software and Online advertising".tr,style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),maxLines: 2,overflow: TextOverflow.ellipsis,),
                    SizedBox(height: height/46,),
                    Text("Company_Gallery".tr,style: dmsbold.copyWith(fontSize: 14),),
                    SizedBox(height: height/36,),
                    SizedBox(
                      height: height/7,
                      child: ListView.builder(
                        itemCount: gallery.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: width/36),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                              child: Image.asset(gallery[index],fit: BoxFit.fill,width: width/2.3,),
                            );
                          },),
                    ),
                    SizedBox(height: height/16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height/15,
                          width: height/15,
                          decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(50),
                            color: Jobstopcolor.white,
                            boxShadow:const  [
                              BoxShadow(
                                blurRadius: 5,
                                color: Jobstopcolor.shedo,
                              )
                            ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(JobstopPngImg.order,color: Jobstopcolor.orenge,),
                          ),
                        ),
                        InkWell(
                          highlightColor: Jobstopcolor.transparent,
                          splashColor: Jobstopcolor.transparent,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const Jobuploadcv();
                            },));
                          },
                          child: Center(
                            child: Container(
                              height: height/15,
                              width: width/1.35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Jobstopcolor.primarycolor
                              ),
                              child:
                              Center(child: Text("Apply Now".tr,style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
