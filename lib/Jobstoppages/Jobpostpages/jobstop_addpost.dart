import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';

class JobAddPost extends StatefulWidget {
  const JobAddPost({Key? key}) : super(key: key);

  @override
  State<JobAddPost> createState() => _JobAddPostState();
}

class _JobAddPostState extends State<JobAddPost> {
  dynamic size;
double height = 0.00;
double width = 0.00;
TextEditingController title = TextEditingController();
TextEditingController description = TextEditingController();
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
            child: Text("Post",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.orenge),),
          )
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add Post",style: dmsbold.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),),
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
            Text("Post title",style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),),
            SizedBox(height: height/46,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      color: Jobstopcolor.greyyy,
                    )
                  ]
              ),
              child: TextField(
                controller:title,
                style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                cursorColor: Jobstopcolor.grey,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Write the title of your post here",
                    hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none),
                    fillColor: Jobstopcolor.white),
              ),
            ),
            SizedBox(height: height/36,),
            Text("Description",style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),),
            SizedBox(height: height/46,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      color: Jobstopcolor.greyyy,
                    )
                  ]
              ),
              child: TextField(
                controller:title,
                style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                cursorColor: Jobstopcolor.grey,
                maxLines: 8,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "What do you want to talk about?",
                    hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none),
                    fillColor: Jobstopcolor.white),
              ),
            ),
          ],
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
