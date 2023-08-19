import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jobspot/JobThemes/themecontroller.dart';

class JobMessageing extends StatefulWidget {
  const JobMessageing({Key? key}) : super(key: key);

  @override
  State<JobMessageing> createState() => _JobMessageingState();
}

class _JobMessageingState extends State<JobMessageing> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  final themedata = Get.put(JobstopThemecontroler());
  TextEditingController search = TextEditingController();
  List<String> chatname = ["Andy Robertson","Giorgio Chiellini","Alex Morgan","Megan Rapinoe","Alessandro Bastoni","Ilkay Gundogan"];
  List<String> chatimg = [JobstopPngImg.photo1,JobstopPngImg.photo2,JobstopPngImg.photo3,JobstopPngImg.photo4,JobstopPngImg.photo5,JobstopPngImg.photo6];
  List<String> msg = ["Oh yes, please send your CV/Res...","Hello sir, Good Morning","I saw the UI/UX Designer vac...","I saw the UI/UX Designer vac...","I saw the UI/UX Designer vac...","I saw the UI/UX Designer vac..."];
  List<String> time = ["5m ago","30m ago","09:30 am","01:00 pm","06:00 pm","Yesterday"];
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title:  Text("Messages".tr,style: dmsbold.copyWith(fontSize: 20),),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset(JobstopPngImg.editpen),
              ),
              Padding(
                padding:  EdgeInsets.only(top: height/46,bottom: height/46,right: width/26),
                child: Image.asset(JobstopPngImg.dots),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/26,vertical: height/96),
          child: Column(
            children: [
              // SizedBox(height: height/10,),
              // Image.asset(JobstopPngImg.nomessage,height: height/3,),
              // SizedBox(height: height/36,),
              // Text("No Message",style: dmsbold.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),),
              // SizedBox(height: height/36,),
              // Text("You currently have no incoming messages\nthank you",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),textAlign: TextAlign.center,),
              // SizedBox(height: height/10,),
              // Center(
              //   child: Container(
              //     height: height/18,
              //     width: width/1.5,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(5),
              //       color: Jobstopcolor.primarycolor,
              //     ),
              //     child: Center(child: Text("Create a message",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
              //   ),
              // ),

              Container(
                height: height/18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Jobstopcolor.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Jobstopcolor.shedo,
                        blurRadius: 5
                    )
                  ]
              ),
                child: TextField(
                  controller:search,
                  style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                  cursorColor: Jobstopcolor.grey,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Search message".tr,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(JobstopPngImg.search,height: height/36,),
                      ),
                      hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      fillColor: Jobstopcolor.white),
                ),
              ),
              SizedBox(height: height/36,),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: chatname.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return const DatingMessages();
                      // },)
                      // );
                    },
                    child: Column(
                      children: [
                        Slidable(
                          endActionPane:  ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SizedBox(width: width/20,),
                              SizedBox(
                                height: height/15,
                                width: width/8,
                                child: SlidableAction(
                                  padding: const EdgeInsets.only(right: 3),
                                  borderRadius: BorderRadius.circular(10),
                                  backgroundColor:  Jobstopcolor.lightpink,
                                  foregroundColor: Jobstopcolor.orenge,
                                  icon:Icons.delete_outline_sharp,
                                  onPressed: (BuildContext context) {
                                    return Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  radius: 25,
                                  child: Image.asset(chatimg[index],fit: BoxFit.fill)),
                              SizedBox(width: width/36,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(chatname[index].toString(),style: dmsbold.copyWith(fontSize: 14,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                                  SizedBox(height: height/150,),
                                  SizedBox(
                                      width: width/2,
                                      child: Text(msg[index].toString(),style: dmsmedium.copyWith(fontSize: 12,color: Jobstopcolor.grey),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(time[index].toString(),style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),),
                                  SizedBox(height: height/150,),
                                  index == 0 ? CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Jobstopcolor.orenge,
                                    child: Text("2",style: dmsmedium.copyWith(fontSize: 14,color: Jobstopcolor.white),),
                                  ) : Container(),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: height/30,)
                      ],
                    ),
                  );
                },),
            ],
          ),
        ),
      ),
    );
  }
}
