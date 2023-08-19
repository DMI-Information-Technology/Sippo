import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';

import 'job_specialization.dart';

class FilterSecond extends StatefulWidget {
  const FilterSecond({Key? key}) : super(key: key);

  @override
  State<FilterSecond> createState() => _FilterSecondState();
}

class _FilterSecondState extends State<FilterSecond> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  String? event;
  String? event1;
  String? event2;
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  List<String> jobname = ["Apprenticeship","Part-time","Full time","Contarct","Project-based"];
  List<String> position = ["Junior","Senior","Leader","Manager"];
  List<String> cityname = ["California, USA","Texaz, USA","New York, USA","Florida, USA"];
  List<String> specializationname = ["Design","Finance","Education","Health","Restuarant","Programmer"];
  int? jobselect;
  int? positionselect;
  int? city;
  int?  specialization;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter".tr,style: dmsbold.copyWith(fontSize: 20),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Last_update".tr,style: dmsbold.copyWith(fontSize: 14),),
                  const Icon(Icons.keyboard_arrow_up_outlined,size: 25,),
                ],
              ),
              SizedBox(
                height: height/20,
                child: RadioListTile(
                  title: Text("Recent",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                  value: "Recent",
                  groupValue: event,
                  activeColor: Jobstopcolor.orenge,
                  onChanged: (value){
                    setState(() {
                      event = value.toString();
                    });
                  },
                ),
              ),
              SizedBox(
                height: height/20,
                child: RadioListTile(
                  title: Text("Last week",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                  value: "Last week",
                  groupValue: event,
                  activeColor: Jobstopcolor.orenge,
                  onChanged: (value){
                    setState(() {
                      event = value.toString();
                    });
                  },
                ),
              ),
              SizedBox(
                height: height/20,
                child: RadioListTile(
                  title: Text("Last month",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                  value: "Last month",
                  groupValue: event,
                  activeColor: Jobstopcolor.orenge,
                  onChanged: (value){
                    setState(() {
                      event = value.toString();
                    });
                  },
                ),
              ),
              SizedBox(
                height: height/20,
                child: RadioListTile(
                  title: Text("Any time",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                  value: "Any time",
                  groupValue: event,
                  activeColor: Jobstopcolor.orenge,
                  onChanged: (value){
                    setState(() {
                      event = value.toString();
                    });
                  },
                ),
              ),
              SizedBox(height: height/96,),
              const Divider(color: Jobstopcolor.grey,),
              SizedBox(height: height/96,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Type_of_workplace".tr,style: dmsbold.copyWith(fontSize: 14),),
                  const Icon(Icons.keyboard_arrow_up_outlined,size: 25,),
                ],
              ),
              SizedBox(
                height: height/20,
                child: RadioListTile(
                  title: Text("On-site",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                  value: "On-site",
                  groupValue: event1,
                  activeColor: Jobstopcolor.orenge,
                  onChanged: (value){
                    setState(() {
                      event1 = value.toString();
                    });
                  },
                ),
              ),
              SizedBox(
                height: height/20,
                child: RadioListTile(
                  title: Text("Hybrid",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                  value: "Hybrid",
                  groupValue: event1,
                  activeColor: Jobstopcolor.orenge,
                  onChanged: (value){
                    setState(() {
                      event1 = value.toString();
                    });
                  },
                ),
              ),
              SizedBox(
                height: height/20,
                child: RadioListTile(
                  title: Text("Remote",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                  value: "Remote",
                  groupValue: event1,
                  activeColor: Jobstopcolor.orenge,
                  onChanged: (value){
                    setState(() {
                      event1 = value.toString();
                    });
                  },
                ),
              ),
              SizedBox(height: height/96,),
              const Divider(color: Jobstopcolor.grey,),
              SizedBox(height: height/96,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Job_Type".tr,style: dmsbold.copyWith(fontSize: 14),),
                  const Icon(Icons.keyboard_arrow_up_outlined,size: 25,),
                ],
              ),
              SizedBox(height: height/46,),
              GridView.builder(
                itemCount: jobname.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2/0.8
                ),
                 itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      jobselect = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: jobselect == index ? Jobstopcolor.orenge : Jobstopcolor.greyyy
                    ),
                    child: Center(
                      child: Text(jobname[index].toString(),style: dmsregular.copyWith(fontSize: 12,color: jobselect == index ? Jobstopcolor.white : Jobstopcolor.darkgrey),
                      ),
                    ),
                  ),
                );
              },),
              SizedBox(height: height/96,),
              const Divider(color: Jobstopcolor.grey,),
              SizedBox(height: height/96,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Position_level".tr,style: dmsbold.copyWith(fontSize: 14),),
                  const Icon(Icons.keyboard_arrow_up_outlined,size: 25,),
                ],
              ),
              SizedBox(height: height/46,),
              GridView.builder(
                itemCount: position.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2/0.8
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        positionselect = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: positionselect == index ? Jobstopcolor.orenge : Jobstopcolor.greyyy
                      ),
                      child: Center(
                        child: Text(position[index].toString(),style: dmsregular.copyWith(fontSize: 12,color: positionselect == index ? Jobstopcolor.white : Jobstopcolor.darkgrey),
                        ),
                      ),
                    ),
                  );
                },),
              SizedBox(height: height/96,),
              const Divider(color: Jobstopcolor.grey,),
              SizedBox(height: height/96,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("City".tr,style: dmsbold.copyWith(fontSize: 14),),
                  const Icon(Icons.keyboard_arrow_up_outlined,size: 25,),
                ],
              ),
              SizedBox(height: height/46,),
              ListView.builder(
                itemCount: cityname.length,
                shrinkWrap: true,
                physics:const  NeverScrollableScrollPhysics(),
                itemBuilder:  (context, index) {
                return  InkWell(
                  highlightColor: Jobstopcolor.transparent,
                  splashColor: Jobstopcolor.transparent,
                  onTap: () {
                    setState(() {
                      city = index;
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: height/46),
                        height: height/50,
                        width: height/50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: city == index
                                  ? Jobstopcolor.orenge
                                  : Jobstopcolor.darkgrey,
                            )),
                        child: Icon(Icons.done,
                            color: city == index
                                ?Jobstopcolor.orenge
                                : Jobstopcolor.transparent,
                            size: 13),
                      ),
                      SizedBox(
                        width: width/36,
                      ),
                      Text(
                        cityname[index].toString(),
                        style: dmsregular.copyWith(fontSize: 12,color:Jobstopcolor.darkgrey),
                      )
                    ],
                  ),
                );
              },),
              SizedBox(height: height/96,),
              const Divider(color: Jobstopcolor.grey,),
              SizedBox(height: height/96,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Salary".tr,style: dmsbold.copyWith(fontSize: 14),),
                  const Icon(Icons.keyboard_arrow_up_outlined,size: 25,),
                ],
              ),
              SizedBox(height: height/46,),
              RangeSlider(
                values: _currentRangeValues,
                max: 100,
                activeColor: Jobstopcolor.orenge,
                labels: RangeLabels(
                  _currentRangeValues.start.roundToDouble().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
              SizedBox(height: height/96,),
              const Divider(color: Jobstopcolor.grey,),
              SizedBox(height: height/96,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Experience".tr,style: dmsbold.copyWith(fontSize: 14),),
                  const Icon(Icons.keyboard_arrow_up_outlined,size: 25,),
                ],
              ),
              SizedBox(
                height: height/20,
                child: RadioListTile(
                  title: Text("No experience",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                  value: "No experience",
                  groupValue: event2,
                  activeColor: Jobstopcolor.orenge,
                  onChanged: (value){
                    setState(() {
                      event2 = value.toString();
                    });
                  },
                ),
              ),
              SizedBox(
                height: height/20,
                child: RadioListTile(
                  title: Text("Less than a year",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                  value: "Less than a year",
                  groupValue: event2,
                  activeColor: Jobstopcolor.orenge,
                  onChanged: (value){
                    setState(() {
                      event2 = value.toString();
                    });
                  },
                ),
              ),
              SizedBox(
                height: height/20,
                child: RadioListTile(
                  title: Text("1-3 years",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                  value: "1-3 years",
                  groupValue: event2,
                  activeColor: Jobstopcolor.orenge,
                  onChanged: (value){
                    setState(() {
                      event2 = value.toString();
                    });
                  },
                ),
              ),
              SizedBox(
                height: height/20,
                child: RadioListTile(
                  title: Text("3-5 years",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                  value: "3-5 years",
                  groupValue: event2,
                  activeColor: Jobstopcolor.orenge,
                  onChanged: (value){
                    setState(() {
                      event2 = value.toString();
                    });
                  },
                ),
              ),
              SizedBox(
                height: height/20,
                child: RadioListTile(
                  title: Text("5-10 years",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                  value: "5-10 years",
                  groupValue: event2,
                  activeColor: Jobstopcolor.orenge,
                  onChanged: (value){
                    setState(() {
                      event2 = value.toString();
                    });
                  },
                ),
              ),
              SizedBox(
                height: height/20,
                child: RadioListTile(
                  title: Text("More than 10 years",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                  value: "More than 10 years",
                  groupValue: event2,
                  activeColor: Jobstopcolor.orenge,
                  onChanged: (value){
                    setState(() {
                      event2 = value.toString();
                    });
                  },
                ),
              ),
              SizedBox(height: height/96,),
              const Divider(color: Jobstopcolor.grey,),
              SizedBox(height: height/96,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Specialization".tr,style: dmsbold.copyWith(fontSize: 14),),
                  const Icon(Icons.keyboard_arrow_up_outlined,size: 25,),
                ],
              ),
              SizedBox(height: height/46,),
              ListView.builder(
                itemCount: specializationname.length,
                shrinkWrap: true,
                physics:const  NeverScrollableScrollPhysics(),
                itemBuilder:  (context, index) {
                  return  InkWell(
                    highlightColor: Jobstopcolor.transparent,
                    splashColor: Jobstopcolor.transparent,
                    onTap: () {
                      setState(() {
                        specialization = index;
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: height/46),
                          height: height/50,
                          width: height/50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: specialization == index
                                    ? Jobstopcolor.orenge
                                    : Jobstopcolor.darkgrey,
                              )),
                          child: Icon(Icons.done,
                              color: specialization == index
                                  ?Jobstopcolor.orenge
                                  : Jobstopcolor.transparent,
                              size: 13),
                        ),
                        SizedBox(
                          width: width/36,
                        ),
                        Text(
                          specializationname[index].toString(),
                          style: dmsregular.copyWith(fontSize: 12,color:Jobstopcolor.darkgrey),
                        )
                      ],
                    ),
                  );
                },),
              SizedBox(height: height/16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: height/15,
                    width: width/5,
                    decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(20),
                        color: Jobstopcolor.white,
                        boxShadow:const  [
                          BoxShadow(
                            blurRadius: 5,
                            color: Jobstopcolor.shedo,
                          )
                        ]
                    ),
                    child: Center(child: Text("Resent",style: dmsregular.copyWith(fontSize: 16,color: Jobstopcolor.orenge),)),
                  ),
                  InkWell(
                    highlightColor: Jobstopcolor.transparent,
                    splashColor: Jobstopcolor.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const Specialization();
                      },));
                    },
                    child: Center(
                      child: Container(
                        height: height/15,
                        width: width/1.5,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
