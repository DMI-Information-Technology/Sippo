import 'package:flutter/material.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/jobstopimges.dart';
import '../sippo_pages/sippo_user_pages/jobstop_search.dart';

class FindYorJopDashBoardCards extends StatelessWidget {
  final String firstCardTitle;
  final String firstCardSubtitle;
  final String secondCardTitle;
  final String secondCardSubtitle;
  final String thirdCardTitle;
  final String thirdCardSubtitle;

  const FindYorJopDashBoardCards({
    required this.firstCardTitle,
    required this.firstCardSubtitle,
    required this.secondCardTitle,
    required this.secondCardSubtitle,
    required this.thirdCardTitle,
    required this.thirdCardSubtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const JobSearch();
              },
            ));
          },
          child: Container(
            height: height / 4,
            width: width / 2.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Jobstopcolor.lightsky,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  JobstopPngImg.headhunting,
                  height: height / 20,
                ),
                SizedBox(
                  height: height / 96,
                ),
                Text(
                  firstCardTitle,
                  style:
                      dmsbold.copyWith(fontSize: 16, color: Jobstopcolor.black),
                ),
                Text(
                  firstCardSubtitle,
                  style: dmsregular.copyWith(
                      fontSize: 14, color: Jobstopcolor.black),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            CustomCard(
              height: height / 9.5,
              width: width / 2.3,
              color: Jobstopcolor.lightprimary,
              title: secondCardTitle,
              subtitle: secondCardSubtitle,
            ),
            SizedBox(
              height: height / 36,
            ),
            CustomCard(
              height: height / 9.5,
              width: width / 2.3,
              color: Jobstopcolor.lightorenge,
              title: thirdCardTitle,
              subtitle: thirdCardSubtitle,
            ),
          ],
        ),
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final String title;
  final String subtitle;

  const CustomCard({
    required this.height,
    required this.width,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: dmsbold.copyWith(fontSize: 16, color: Jobstopcolor.black),
          ),
          Text(
            subtitle,
            style: dmsregular.copyWith(fontSize: 14, color: Jobstopcolor.black),
          ),
        ],
      ),
    );
  }
}
