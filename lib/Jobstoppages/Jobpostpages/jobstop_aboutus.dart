import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import '../../JobThemes/themecontroller.dart';

class JobstopAbouts extends StatefulWidget {
  const JobstopAbouts({Key? key}) : super(key: key);

  @override
  State<JobstopAbouts> createState() => _JobstopAboutsState();
}

class _JobstopAboutsState extends State<JobstopAbouts> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  final themedata = Get.put(JobstopThemecontroler());
  final List<String> steps = <String>["About us", "Post","Jobs"];
  List<String> gallery = [JobstopPngImg.gallery1,JobstopPngImg.gallery2];
  int selected = 0;
  List<String> name = ["UI/UX Designer", "IT Programmer"];
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {},
                child: Image.asset(JobstopPngImg.dots,)
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
              padding: EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: height/20,
                        width: width/2.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Jobstopcolor.lightpink,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add,size: 20,color: Jobstopcolor.red,),
                            SizedBox(width: width/36,),
                            Text("Follow",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.red),)
                          ],
                        ),
                      ),
                      Container(
                        height: height/20,
                        width: width/2.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Jobstopcolor.lightpink,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           Image.asset(JobstopPngImg.visiticon,height: height/46,),
                            SizedBox(width: width/36,),
                            Text("Visit website",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.red),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height/36,),
                  Container(
                    height: height / 15,
                    width: width / 1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Jobstopcolor.light),
                    child: Padding(
                      padding: EdgeInsets.only(left: width / 36),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: steps.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            highlightColor: Jobstopcolor.transparent,
                            splashColor: Jobstopcolor.transparent,
                            onTap: () {
                              setState(() {
                                selected = index;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: height / 116),
                              child: Container(
                                width: width / 3.5,
                                decoration: BoxDecoration(
                                    color: selected == index
                                        ? Jobstopcolor.orenge
                                        : Jobstopcolor.transparent,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                      steps[index].toString(),
                                      style: dmsbold.copyWith(
                                          fontSize: 14, color:selected == index
                                          ? Jobstopcolor.white : Jobstopcolor.primarycolor),
                                    )),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: height/36,),
                  if(selected == 0)... [
                    Text("About_Company".tr,style: dmsbold.copyWith(fontSize: 14),),
                    SizedBox(height: height/76,),
                    Text("Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.\n\nAt vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas .\n\nNor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain.".tr,
                      style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),maxLines: 15,overflow: TextOverflow.ellipsis,),
                    SizedBox(height: height/36,),
                    Text("Website".tr,style: dmsbold.copyWith(fontSize: 14),),
                    SizedBox(height: height/120,),
                    Text("https://www.google.com".tr,style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.orenge),),
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
                            // Navigator.push(context, MaterialPageRoute(builder: (context) {
                            //   return const Jobuploadcv();
                            // },));
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
                  ]else if(selected == 1)...[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Jobstopcolor.white,
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 5,
                                color: Jobstopcolor.shedo
                            )
                          ]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/66),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(JobstopPngImg.google,height: height/16,),
                                      SizedBox(width: width/46,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Google Inc",style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.black),),
                                          SizedBox(height: height/150,),
                                          Row(
                                            children: [
                                              Image.asset(JobstopPngImg.watch,height: height/56,),
                                              SizedBox(width: width/46,),
                                              Text("21 minuts ago",style: dmsregular.copyWith(fontSize: 10,color: Jobstopcolor.grey),),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height/46,),
                                  Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco labo... Read more",
                                    style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),maxLines: 4,overflow: TextOverflow.ellipsis,),
                                  SizedBox(height: height/56,),
                                  Stack(
                                    children: [
                                      Container(
                                        height: height/5,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Image.asset(JobstopPngImg.post,fit: BoxFit.fill,width: width/1,),
                                      ),
                                      const Positioned(
                                        top: 50,
                                          left: 100,
                                          child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Jobstopcolor.greyyy,
                                            child: Icon(Icons.play_arrow_rounded,size: 20,color: Jobstopcolor.black,),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: height/56,),
                                  Text("What's it like to work at Google?",
                                    style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),),
                                  Text("Youtube.com",
                                    style: dmsregular.copyWith(fontSize: 10,color: Jobstopcolor.black),),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: height/15,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                                color: Jobstopcolor.primary
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: width/15),
                              child: Row(
                                children: [
                                  const Icon(Icons.favorite,color: Jobstopcolor.red,size: 20,),
                                  SizedBox(width: width/96,),
                                  Text("12",style: dmsregular.copyWith(fontSize: 10,color: Jobstopcolor.grey),),
                                  SizedBox(width: width/16,),
                                  Image.asset(JobstopPngImg.message,color: Jobstopcolor.grey,height: height/46,),
                                  SizedBox(width: width/96,),
                                  Text("10",style: dmsregular.copyWith(fontSize: 10,color: Jobstopcolor.grey),),
                                  SizedBox(width: width/2.5,),
                                  Image.asset(JobstopPngImg.union,color: Jobstopcolor.grey,height: height/46,),
                                  SizedBox(width: width/96,),
                                  Text("2",style: dmsregular.copyWith(fontSize: 10,color: Jobstopcolor.grey),),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]else ...[
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: name.length,
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
                            margin: EdgeInsets.only(bottom: height/36,),
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
                                        child: Image.asset(JobstopPngImg.google,height: height/26,),
                                      ),
                                      const Spacer(),
                                      Image.asset(JobstopPngImg.order,height: height/36,color: Jobstopcolor.grey,),
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
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
