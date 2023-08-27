import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/jobstopimges.dart';
import '../JobGlobalclass/text_font_size.dart';

class ResumeCardWidget extends StatelessWidget {
  final void Function()? onDeleteTapped;

  const ResumeCardWidget({
    this.onDeleteTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Row(
      children: [
        Image.asset(
          JobstopPngImg.pdf,
          height: height / 16,
        ),
        SizedBox(
          width: width / 36,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                "Jamet kudasi - CV - UI/UX Designer",
                style: dmsregular.copyWith(
                    fontSize: FontSize.title6(context),
                    color: Jobstopcolor.primarycolor),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: height / 150,
              ),
              Text(
                "867 Kb . 14 Feb 2022 at 11:30 am",
                style:
                    dmsregular.copyWith(fontSize: 12, color: Jobstopcolor.grey),
              ),
            ],
          ),
        ),
        if (onDeleteTapped != null) ...[
          SizedBox(width: width / 32),
          Image.asset(
            JobstopPngImg.deleted,
            height: height / 36,
            color: Jobstopcolor.red,
          ),
        ]
      ],
    );
  }
}
