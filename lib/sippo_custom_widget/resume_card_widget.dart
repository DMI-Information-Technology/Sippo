import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/jobstopimges.dart';
import '../JobGlobalclass/text_font_size.dart';

class ResumeCardWidget extends StatelessWidget {
  final void Function()? onDeleteTapped;
  final CustomFileModel? resume;

  const ResumeCardWidget({
    this.resume,
    this.onDeleteTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          resume?.type == 'image'
              ? JobstopPngImg.galleryicon
              : JobstopPngImg.pdf,
          color: resume?.type == 'image' ? Jobstopcolor.primarycolor : null,
          height: height / 16,
        ),
        SizedBox(width: width / 36),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                resume?.name ?? "unknown",
                style: dmsregular.copyWith(
                  fontSize: FontSize.title6(context),
                  color: Jobstopcolor.primarycolor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: height / CustomStyle.varyHuge),
              Text(
                "${resume?.sizeToString ?? 'unknown'} . ${resume?.uploadDateToString ?? 'unknown'}",
                style: dmsregular.copyWith(
                  fontSize: FontSize.label(context),
                  color: Colors.black54,
                ),
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
