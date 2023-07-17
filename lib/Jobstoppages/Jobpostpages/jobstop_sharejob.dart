import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';

class JobstopShared extends StatefulWidget {
  const JobstopShared({Key? key}) : super(key: key);

  @override
  State<JobstopShared> createState() => _JobstopSharedState();
}

class _JobstopSharedState extends State<JobstopShared> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.close,size: 20,)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Post",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.orenge),),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/26,vertical: height/96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Shared a Job",style: dmsbold.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),),
              SizedBox(height: height/36,),
              Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(JobstopPngImg.photo),
                      ),
                      SizedBox(width: width/36,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Orlando Diggs",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                          SizedBox(height: height/150,),
                          Text("California, USA",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: height/36,),
              Text("Description",style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),),
              SizedBox(height: height/46,),
              Container(
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
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text("Hey guys",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                        SizedBox(height: height/96,),
                        Text("Today I am opening a job vacancy in the field of UI/UX Designer at an Apple company. To see a job description, please see below.",
                          style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),maxLines: 3,overflow: TextOverflow.ellipsis,),
                      SizedBox(height: height/46,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Jobstopcolor.greyyy
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(JobstopPngImg.applelogo,height: height/18,),
                              SizedBox(width: width/36,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("UI/UX Designer",style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),),
                                  SizedBox(height: height/100,),
                                  Text("Job vacancies from Apple company",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                                  Text("California, USA . On-site",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                                  SizedBox(height: height/46,),
                                  Container(
                                    height: height/22,
                                    width: width/2.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Jobstopcolor.primarycolor)
                                    ),
                                    child: Center(
                                      child: Text("Application details",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/66),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.camera_alt_rounded,color: Jobstopcolor.orenge,size: 20,),
              Image.asset(JobstopPngImg.galleryicon,height: height/46,),
              SizedBox(width: width/2.5,),
              Text("Add hashtag",style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.orenge),)
            ],
          ),
        )
    );
  }
}
