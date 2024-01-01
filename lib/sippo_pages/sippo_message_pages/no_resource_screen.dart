import 'package:flutter/material.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';

import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';

class NoResourceScreen extends StatelessWidget {
  const NoResourceScreen({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  final String title;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    // double width = size.width;
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: height / 36,
          ),
          Text(
            title,
            style: dmsbold.copyWith(
                fontSize: FontSize.title3(context),
                color: SippoColor.primarycolor),
          ),
          SizedBox(
            height: height / 36,
          ),
          Text(
            description,
            style: dmsregular.copyWith(
              fontSize: FontSize.paragraph3(context),
              color: SippoColor.darkgrey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: height / 10,
          ),
          Image.asset(
            image,
            height: height / 4,
          ),
          SizedBox(
            height: height / 8,
          ),
        ],
      ),
    );
  }
}
