import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';

import 'job_allnotification.dart';

class JobNotification extends StatefulWidget {
  const JobNotification({Key? key}) : super(key: key);

  @override
  State<JobNotification> createState() => _JobNotificationState();
}

class _JobNotificationState extends State<JobNotification> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  int select = 0;
  List<String> listimg = [JobstopPngImg.googlelogo,JobstopPngImg.dribbblelogo,JobstopPngImg.twitterlogo,JobstopPngImg.applelogo,JobstopPngImg.facebooklogo];
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
   appBar: AppBar(
     actions: [
       Padding(
         padding: const EdgeInsets.all(12.0),
         child: InkWell(
           splashColor: Jobstopcolor.transparent,
           highlightColor: Jobstopcolor.transparent,
             onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) {
                 return const AllNotification();
               },));
             },
             child: Text("Read all",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.orenge),)),
       )
     ],
   ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: height/10,),
              // Text("No notifications",style: dmsbold.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),),
              // SizedBox(height: height/36,),
              // Text("You have no notifications at this time\nthank you",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),textAlign: TextAlign.center,),
              // SizedBox(height: height/10,),
              // Center(child: Image.asset(JobstopPngImg.notificationimg,height: height/4,)),

              Text("Notifications",style: dmsbold.copyWith(fontSize: 20),),
              SizedBox(height: height/36,),
              ListView.builder(
                itemCount: listimg.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                return   InkWell(
                  splashColor: Jobstopcolor.transparent,
                  highlightColor: Jobstopcolor.transparent,
                  onTap:  () {
                    setState(() {
                      select = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: height/36),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: select == index ? Jobstopcolor.primary :  Jobstopcolor.white,
                      boxShadow:   [
                        BoxShadow(
                          blurRadius:  select == index ? 0 : 5,
                          color:  Jobstopcolor.shedo
                        )
                      ]
                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(listimg[index].toString(),height: height/18,),
                          SizedBox(width: width/36,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Application sent",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                              SizedBox(height: height/100,),
                              SizedBox(
                                width: width/1.5,
                                child: Text("Applications for Google companies have entered for company review",
                                  style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),maxLines: 2,overflow: TextOverflow.ellipsis,),
                              ),
                              SizedBox(height: height/40,),
                              Row(
                                children: [
                                  Text("25 minutes ago",style: dmsregular.copyWith(fontSize: 11,color: Jobstopcolor.grey),),
                                  SizedBox(width: width/3,),
                                  Text("Delete",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.red),),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },)
            ],
          ),
        ),
      ),
    );
  }
}
