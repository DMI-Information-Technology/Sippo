import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import '../../sippo_custom_widget/resume_card_widget.dart';

class JobApplication extends StatelessWidget {
  const JobApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = context.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.fromWidth(CustomStyle.s),
          ),
          child: Column(
            children: [
              AutoSizeText(
                "Your application",
                style: dmsbold.copyWith(
                  fontSize: FontSize.title3(context),
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              _buildApplicationContainer(context),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              SizedBox(
                width: width / 1.5,
                child: CustomButton(
                  onTapped: () {},
                  text: "Apply for more jobs",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApplicationContainer(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(
        bottom: context.fromHeight(CustomStyle.l),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.s),
          vertical: context.fromHeight(CustomStyle.m),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              JobstopPngImg.googlelogo,
              height: context.fromHeight(CustomStyle.xs),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Text(
              "UI/UX Designer",
              style: dmsbold.copyWith(
                fontSize: FontSize.title6(context),
                color: Colors.black87,
              ),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.huge2)),
            Text(
              "Google Inc. California, USA",
              style: TextStyle(
                fontSize: FontSize.label(context),
                color: Colors.grey,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: context.fromHeight(CustomStyle.huge2)),
            _buildDetailRow(
              context,
              "Shipped on February 14, 2022 at 11:30 am",
            ),
            _buildDetailRow(context, "Updated by recruiter 8 hours ago"),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Text(
              "Job details",
              style: dmsbold.copyWith(
                fontSize: FontSize.title6(context),
                color: Colors.black87,
              ),
            ),
            _buildDetailRow(context, "Senior designer"),
            _buildDetailRow(context, "Full time"),
            _buildDetailRow(context, "1-3 Years work experience"),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Text(
              "Application details",
              style: dmsbold.copyWith(
                fontSize: FontSize.title6(context),
                color: Colors.black87,
              ),
            ),
            _buildDetailRow(context, "CV/Resume"),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            Card(
              margin: EdgeInsets.zero,
              color: Jobstopcolor.lightprimary2,
              child: Padding(
                padding: EdgeInsets.all(context.fromWidth(CustomStyle.m)),
                child: CvCardWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String text) {

    return Row(
      children: [
        Image.asset(
          JobstopPngImg.dot,
          height: context.fromHeight(CustomStyle.huge2),
          color: Colors.grey,
        ),
        SizedBox(height: context.fromWidth(CustomStyle.spaceBetween)),
        Text(
          text,
          style:
              TextStyle(fontSize: FontSize.label(context), color: Colors.grey),
        ),
      ],
    );
  }

  // Widget _buildPdfContainer(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   double height = size.height;
  //   double width = size.width;
  //
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(20),
  //       color: Colors.blue,
  //     ),
  //     child: Padding(
  //       padding:
  //           EdgeInsets.symmetric(horizontal: width / 26, vertical: height / 46),
  //       child: Row(
  //         children: [
  //           Image.asset(
  //             JobstopPngImg.dot,
  //             height: height / 150,
  //             color: Colors.grey,
  //           ),
  //           SizedBox(width: width / 36),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 "Jamet kudasi - CV - UI/UX Designer",
  //                 style: TextStyle(fontSize: 12, color: Colors.blue),
  //               ),
  //               SizedBox(height: height / 150),
  //               Text(
  //                 "867 Kb . 14 Feb 2022 at 11:30 am",
  //                 style: TextStyle(fontSize: 12, color: Colors.grey),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

// class JobApplication extends StatelessWidget {
//   const JobApplication({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     double height = size.height;
//     double width = size.width;
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: width / 26),
//           child: Column(
//             children: [
//               Text(
//                 "Your application",
//                 style: dmsbold.copyWith(
//                     fontSize: 20, color: Jobstopcolor.primarycolor),
//               ),
//               SizedBox(
//                 height: height / 26,
//               ),
//               Container(
//                 margin: EdgeInsets.only(
//                   bottom: height / 36,
//                 ),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Jobstopcolor.white,
//                     boxShadow: const [
//                       BoxShadow(
//                         blurRadius: 5,
//                         color: Jobstopcolor.greyyy,
//                       )
//                     ]),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: width / 26, vertical: height / 46),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Image.asset(
//                         JobstopPngImg.googlelogo,
//                         height: height / 18,
//                       ),
//                       SizedBox(
//                         height: height / 36,
//                       ),
//                       Text(
//                         "UI/UX Designer",
//                         style: dmsbold.copyWith(
//                             fontSize: 14, color: Jobstopcolor.primarycolor),
//                       ),
//                       SizedBox(
//                         height: height / 150,
//                       ),
//                       Text(
//                         "Google inc . California, USA",
//                         style: dmsregular.copyWith(
//                             fontSize: 12, color: Jobstopcolor.darkgrey),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(
//                         height: height / 100,
//                       ),
//                       Row(
//                         children: [
//                           Image.asset(
//                             JobstopPngImg.dot,
//                             height: height / 150,
//                             color: Jobstopcolor.grey,
//                           ),
//                           SizedBox(
//                             width: width / 36,
//                           ),
//                           Text(
//                             "Shipped on February 14, 2022 at 11:30 am",
//                             style: dmsregular.copyWith(
//                                 fontSize: 12, color: Jobstopcolor.grey),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: height / 100,
//                       ),
//                       Row(
//                         children: [
//                           Image.asset(
//                             JobstopPngImg.dot,
//                             height: height / 150,
//                             color: Jobstopcolor.grey,
//                           ),
//                           SizedBox(
//                             width: width / 36,
//                           ),
//                           Text(
//                             "Updated by recruiter 8 hours ago",
//                             style: dmsregular.copyWith(
//                                 fontSize: 12, color: Jobstopcolor.grey),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: height / 36,
//                       ),
//                       Text(
//                         "Job details",
//                         style: dmsbold.copyWith(
//                             fontSize: 14, color: Jobstopcolor.primarycolor),
//                       ),
//                       SizedBox(
//                         height: height / 100,
//                       ),
//                       Row(
//                         children: [
//                           Image.asset(
//                             JobstopPngImg.dot,
//                             height: height / 150,
//                             color: Jobstopcolor.grey,
//                           ),
//                           SizedBox(
//                             width: width / 36,
//                           ),
//                           Text(
//                             "Senior designer",
//                             style: dmsregular.copyWith(
//                                 fontSize: 12, color: Jobstopcolor.grey),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: height / 100,
//                       ),
//                       Row(
//                         children: [
//                           Image.asset(
//                             JobstopPngImg.dot,
//                             height: height / 150,
//                             color: Jobstopcolor.grey,
//                           ),
//                           SizedBox(
//                             width: width / 36,
//                           ),
//                           Text(
//                             "Full time",
//                             style: dmsregular.copyWith(
//                                 fontSize: 12, color: Jobstopcolor.grey),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: height / 100,
//                       ),
//                       Row(
//                         children: [
//                           Image.asset(
//                             JobstopPngImg.dot,
//                             height: height / 150,
//                             color: Jobstopcolor.grey,
//                           ),
//                           SizedBox(
//                             width: width / 36,
//                           ),
//                           Text(
//                             "1-3 Years work experience",
//                             style: dmsregular.copyWith(
//                                 fontSize: 12, color: Jobstopcolor.grey),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: height / 36,
//                       ),
//                       Text(
//                         "Application details",
//                         style: dmsbold.copyWith(
//                             fontSize: 14, color: Jobstopcolor.primarycolor),
//                       ),
//                       SizedBox(
//                         height: height / 100,
//                       ),
//                       Row(
//                         children: [
//                           Image.asset(
//                             JobstopPngImg.dot,
//                             height: height / 150,
//                             color: Jobstopcolor.grey,
//                           ),
//                           SizedBox(
//                             width: width / 36,
//                           ),
//                           Text(
//                             "CV/Resume",
//                             style: dmsregular.copyWith(
//                                 fontSize: 12, color: Jobstopcolor.grey),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: height / 100,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: Jobstopcolor.primary,
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: width / 26, vertical: height / 46),
//                           child: Row(
//                             children: [
//                               Image.asset(
//                                 JobstopPngImg.pdf,
//                                 height: height / 16,
//                               ),
//                               SizedBox(
//                                 width: width / 36,
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Jamet kudasi - CV - UI/UX Designer",
//                                     style: dmsregular.copyWith(
//                                         fontSize: 12,
//                                         color: Jobstopcolor.primarycolor),
//                                   ),
//                                   SizedBox(
//                                     height: height / 150,
//                                   ),
//                                   Text(
//                                     "867 Kb . 14 Feb 2022 at 11:30 am",
//                                     style: dmsregular.copyWith(
//                                         fontSize: 12, color: Jobstopcolor.grey),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: height / 36,
//               ),
//               InkWell(
//                 onTap: () {
//                   // Navigator.push(context, MaterialPageRoute(builder: (context) {
//                   //   return const JobApplication();
//                   // },));
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: Jobstopcolor.primarycolor),
//                   child: Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: width / 10, vertical: height / 66),
//                       child: Text("Apply for more jobs",
//                           style: dmsbold.copyWith(
//                               fontSize: 14, color: Jobstopcolor.white))),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
