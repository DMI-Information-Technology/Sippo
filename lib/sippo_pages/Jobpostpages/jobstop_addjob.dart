import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';

import 'jobstop_editjob.dart';
import 'jobstop_position.dart';
import 'jobstop_sharejob.dart';

class JobstopAddjob extends StatefulWidget {
  const JobstopAddjob({Key? key}) : super(key: key);

  @override
  State<JobstopAddjob> createState() => _JobstopAddjobState();
}

class _JobstopAddjobState extends State<JobstopAddjob> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  String? event;
  List<String> listing = ["Job position*","Type of workplace","Job location","Company","Employment type","Description"];
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
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const JobstopShared();
              },));
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Post",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.orenge),),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/76),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add_a_job",style: dmsbold.copyWith(fontSize: 16),),
              SizedBox(height: height/36,),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listing.length,
                itemBuilder: (context, index) {
                 return Container(
                   margin: EdgeInsets.only(bottom: height/36),
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
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(listing[index].toString(),style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                         InkWell(
                           onTap: () {
                             if(index == 0){
                               Navigator.push(context, MaterialPageRoute(builder: (context) {
                                 return const JobstopPosition(type: "1");
                               },));
                             }else if(index == 1){
                               _showworlplace();
                             }else if(index == 2){
                               Navigator.push(context, MaterialPageRoute(builder: (context) {
                                 return const JobstopPosition(type: "2");
                               },));
                             }else if(index == 3){
                               Navigator.push(context, MaterialPageRoute(builder: (context) {
                                 return const JobstopPosition(type: "3");
                               },));
                             }else if(index == 4){
                               _showjobtype();
                             }else{
                               Navigator.push(context, MaterialPageRoute(builder: (context) {
                                 return const EditAddJob();
                               },));
                             }
                           },
                           child: const CircleAvatar(
                             radius: 10,
                             backgroundColor: Jobstopcolor.light,
                             child: Icon(Icons.add,size: 15,color: Jobstopcolor.orenge,),
                           ),
                         )
                       ],
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
  _showworlplace() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            decoration: const BoxDecoration(
              color: Jobstopcolor.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
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
                  SizedBox(height: height / 26,),
                  Text("Choose the type of workplace", style: dmsbold.copyWith(
                      fontSize: 16, color: Jobstopcolor.primarycolor),),
                  SizedBox(height: height / 100,),
                  Text(
                    "Decide and choose the type of place to work\naccording to what you want",
                    style: dmsregular.copyWith(
                        fontSize: 12, color: Jobstopcolor.darkgrey),
                    textAlign: TextAlign.center,),
                  SizedBox(height: height / 26,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("On-site", style: dmsbold.copyWith(
                              fontSize: 14, color: Jobstopcolor.primarycolor),),
                          SizedBox(height: height/150,),
                          Text("Employees come to work",
                            style: dmsregular.copyWith(
                                fontSize: 12, color: Jobstopcolor.grey),),
                        ],
                      ),
                      SizedBox(
                        height: height / 20,
                        child: Radio(
                          value: "On-site",
                          groupValue: event,
                          activeColor: Jobstopcolor.orenge,
                          onChanged: (value) {
                            setState(() {
                              event = value.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 66,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hybrid", style: dmsbold.copyWith(
                              fontSize: 14, color: Jobstopcolor.primarycolor),),
                          SizedBox(height: height/150,),
                          Text("Employees work directly on site or off site",
                            style: dmsregular.copyWith(
                                fontSize: 12, color: Jobstopcolor.grey),),
                        ],
                      ),
                      SizedBox(
                        height: height / 20,
                        child: Radio(
                          value: "Hybrid",
                          groupValue: event,
                          activeColor: Jobstopcolor.orenge,
                          onChanged: (value) {
                            setState(() {
                              event = value.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 66,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Remote", style: dmsbold.copyWith(
                              fontSize: 14, color: Jobstopcolor.primarycolor),),
                          SizedBox(height: height/150,),
                          Text("Employees working off site",
                            style: dmsregular.copyWith(
                                fontSize: 12, color: Jobstopcolor.grey),),
                        ],
                      ),
                      SizedBox(
                        height: height / 20,
                        child: Radio(
                          value: "Remote",
                          groupValue: event,
                          activeColor: Jobstopcolor.orenge,
                          onChanged: (value) {
                            setState(() {
                              event = value.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
    },);
  }
  _showjobtype(){
    showModalBottomSheet(
      context: context,
      builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
        return Container(
          decoration: const BoxDecoration(
            color: Jobstopcolor.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          ),
          height: height / 2,
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
                SizedBox(height: height / 26,),
                Text("Choose Job Type", style: dmsbold.copyWith(
                    fontSize: 16, color: Jobstopcolor.primarycolor),),
                SizedBox(height: height / 100,),
                Text(
                  "Determine and choose the type of work according to\nwhat you want",
                  style: dmsregular.copyWith(
                      fontSize: 12, color: Jobstopcolor.darkgrey),
                  textAlign: TextAlign.center,),
                SizedBox(height: height / 26,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Full time", style: dmsbold.copyWith(
                        fontSize: 14, color: Jobstopcolor.primarycolor),),
                    SizedBox(
                      height: height / 20,
                      child: Radio(
                        value: "Full time",
                        groupValue: event,
                        activeColor: Jobstopcolor.orenge,
                        onChanged: (value) {
                          setState(() {
                            event = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Part time", style: dmsbold.copyWith(
                        fontSize: 14, color: Jobstopcolor.primarycolor),),
                    SizedBox(
                      height: height / 20,
                      child: Radio(
                        value: "Part time",
                        groupValue: event,
                        activeColor: Jobstopcolor.orenge,
                        onChanged: (value) {
                          setState(() {
                            event = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Contract", style: dmsbold.copyWith(
                        fontSize: 14, color: Jobstopcolor.primarycolor),),
                    SizedBox(
                      height: height / 20,
                      child: Radio(
                        value: "Contract",
                        groupValue: event,
                        activeColor: Jobstopcolor.orenge,
                        onChanged: (value) {
                          setState(() {
                            event = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Temporary", style: dmsbold.copyWith(
                        fontSize: 14, color: Jobstopcolor.primarycolor),),
                    SizedBox(
                      height: height / 20,
                      child: Radio(
                        value: "Temporary",
                        groupValue: event,
                        activeColor: Jobstopcolor.orenge,
                        onChanged: (value) {
                          setState(() {
                            event = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Volunteer", style: dmsbold.copyWith(
                        fontSize: 14, color: Jobstopcolor.primarycolor),),
                    SizedBox(
                      height: height / 20,
                      child: Radio(
                        value: "Volunteer",
                        groupValue: event,
                        activeColor: Jobstopcolor.orenge,
                        onChanged: (value) {
                          setState(() {
                            event = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Apprenticeship", style: dmsbold.copyWith(
                        fontSize: 14, color: Jobstopcolor.primarycolor),),
                    SizedBox(
                      height: height / 20,
                      child: Radio(
                        value: "Apprenticeship",
                        groupValue: event,
                        activeColor: Jobstopcolor.orenge,
                        onChanged: (value) {
                          setState(() {
                            event = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },);
    },);
  }
}
