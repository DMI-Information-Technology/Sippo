import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/jobstopimges.dart';
import '../JobGlobalclass/text_font_size.dart';
import '../sippo_data/model/profile_model/profile_resource_model/cv_file_model.dart';

class CvCardWidget extends StatelessWidget {
  final VoidCallback? onDeleteTapped;
  final CustomFileModel? _fileCv;
  final CvModel? _remoteCv;
  final VoidCallback? onCvTapped;
  final String? createAt;

  const CvCardWidget({
    CustomFileModel? fileCv,
    this.onDeleteTapped,
    super.key,
    this.onCvTapped,
  })  : _fileCv = fileCv,
        _remoteCv = null,
        this.createAt = null;

  CvCardWidget.fromRemote({
    CvModel? remoteCv,
    this.onDeleteTapped,
    super.key,
    this.onCvTapped,
    this.createAt,
  })  : _fileCv = null,
        _remoteCv = remoteCv;

  @override
  Widget build(BuildContext context) {
    print(_fileCv);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return InkWell(
      onTap: onCvTapped,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildImage(context),
          SizedBox(width: width / 36),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  (_fileCv?.name ?? _remoteCv?.name) ?? "",
                  style: dmsregular.copyWith(
                    fontSize: FontSize.title6(context),
                    color: SippoColor.primarycolor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: height / CustomStyle.varyHuge),
                Text(
                  "${(_fileCv?.sizeToString ?? _remoteCv?.size) ?? ''}, ${(createAt ?? _fileCv?.uploadDateToString) ?? ''}",
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
              color: SippoColor.red,
            ),
          ]
        ],
      ),
    );
  }

  Image _buildImage(BuildContext context) {
    if (_fileCv == null) {
      return Image.asset(
        _remoteCv?.mimeType?.contains('image') == true
            ? JobstopPngImg.galleryicon
            : JobstopPngImg.pdf,
        color: _remoteCv?.mimeType?.contains('image') == true
            ? SippoColor.primarycolor
            : null,
        height: context.height / 21,
        width: context.height / 21,
      );
    }
    return Image.asset(
      _fileCv?.type == 'image' ? JobstopPngImg.galleryicon : JobstopPngImg.pdf,
      color: _fileCv?.type == 'image' ? SippoColor.primarycolor : null,
      height: context.height / 21,
      width: context.height / 21,
    );
  }
}
