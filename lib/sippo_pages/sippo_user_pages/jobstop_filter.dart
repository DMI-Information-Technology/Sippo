import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';

import 'job_filtersecond.dart';

class JobstopFilter extends StatefulWidget {
  const JobstopFilter({Key? key}) : super(key: key);

  @override
  State<JobstopFilter> createState() => _JobstopFilterState();
}

class _JobstopFilterState extends State<JobstopFilter> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  RangeValues _currentRangeValues = const RangeValues(40, 80);
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
              Text("Category".tr,style: dmsbold.copyWith(fontSize: 14),),
              SizedBox(height: height/46,),
              Container(
                width: width/1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Jobstopcolor.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Jobstopcolor.greyyy,
                      )
                    ]
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                  child: Text("Design",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.black),),
                ),
              ),
              SizedBox(height: height/36,),
              Text("Sub_Category".tr,style: dmsbold.copyWith(fontSize: 14),),
              SizedBox(height: height/46,),
              Container(
                width: width/1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Jobstopcolor.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Jobstopcolor.greyyy,
                      )
                    ]
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                  child: Text("UI/UX Design",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.black),),
                ),
              ),
              SizedBox(height: height/36,),
              Text("Location".tr,style: dmsbold.copyWith(fontSize: 14),),
              SizedBox(height: height/46,),
              Container(
                width: width/1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Jobstopcolor.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Jobstopcolor.greyyy,
                      )
                    ]
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                  child: Text("California",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.black),),
                ),
              ),
              SizedBox(height: height/36,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text("Minimum_Salary",style: dmsregular.copyWith(fontSize: 14),),
                   Text("Maximum_Salary",style: dmsregular.copyWith(fontSize: 14),),
                ],
              ),
              SizedBox(height: height/46,),
              Text("Salary".tr,style: dmsbold.copyWith(fontSize: 14),),
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
              const Divider(color: Jobstopcolor.grey,),
              SizedBox(height: height/46,),
              Text("Job_Type".tr,style: dmsbold.copyWith(fontSize: 14),),
              SizedBox(height: height/36,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: height/28,
                    width: width/3.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Jobstopcolor.light
                    ),
                    child:  Center(child: Text("Full time",style: dmsregular.copyWith(fontSize: 10,color: Jobstopcolor.darkgrey))),),
                  Container(
                    height: height/28,
                    width: width/3.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Jobstopcolor.light
                    ),
                    child:  Center(child: Text("Part time",style: dmsregular.copyWith(fontSize: 10,color: Jobstopcolor.darkgrey))),),
                  Container(
                    height: height/28,
                    width: width/3.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Jobstopcolor.light
                    ),
                    child:  Center(child: Text("Remote",style: dmsregular.copyWith(fontSize: 10,color: Jobstopcolor.darkgrey))),),
                ],
              ),
              SizedBox(height: height/16,),
              InkWell(
                highlightColor: Jobstopcolor.transparent,
                splashColor: Jobstopcolor.transparent,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const FilterSecond();
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
            ],
          ),
        ),
      ),
    );
  }
}
