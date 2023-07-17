import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';

class EditAddJob extends StatefulWidget {
  const EditAddJob({Key? key}) : super(key: key);

  @override
  State<EditAddJob> createState() => _EditAddJobState();
}

class _EditAddJobState extends State<EditAddJob> {
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
            Text("Add_a_job",style: dmsbold.copyWith(fontSize: 16),),
            SizedBox(height: height/36,),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Job position*",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                    Image.asset(JobstopPngImg.edit,height: height/36,)
                  ],
                ),
                SizedBox(height: height/100,),
                Text("Administrative Assistant",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
              ],
            ),
          ),
        ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Type of workplace",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                    Image.asset(JobstopPngImg.edit,height: height/36,)
                  ],
                ),
                SizedBox(height: height/100,),
                Text("On-site",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
              ],
            ),
          ),
        ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Job location",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                        Image.asset(JobstopPngImg.edit,height: height/36,)
                      ],
                    ),
                    SizedBox(height: height/100,),
                    Text("California, USA",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                  ],
                ),
              ),
            ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Company",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                        Image.asset(JobstopPngImg.edit,height: height/36,)
                      ],
                    ),
                    SizedBox(height: height/100,),
                    Text("Apple Inc",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                  ],
                ),
              ),
            ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Employment type",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                        Image.asset(JobstopPngImg.edit,height: height/36,)
                      ],
                    ),
                    SizedBox(height: height/100,),
                    Text("Full Time",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                  ],
                ),
              ),
            ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Description",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                        Image.asset(JobstopPngImg.edit,height: height/36,)
                      ],
                    ),
                    SizedBox(height: height/100,),
                    const Divider(color: Jobstopcolor.grey,),
                    SizedBox(height: height/100,),
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lectus id commodo egestas metus interdum dolor.",
                      style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),maxLines: 3,overflow: TextOverflow.ellipsis,),
                  ],
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
