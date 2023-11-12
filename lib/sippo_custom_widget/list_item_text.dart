import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/jobstopimges.dart';
import '../JobGlobalclass/text_font_size.dart';

class ListTextItem extends StatelessWidget {
  const ListTextItem({
    super.key,
    this.text,
    this.startCrossAlignment = false,
    this.fontSize,
    this.onTap,
  });

  final VoidCallback? onTap;
  final double? fontSize;
  final bool startCrossAlignment;
  final String? text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Row(
      crossAxisAlignment: startCrossAlignment
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildDotBeforeText(context),
        SizedBox(width: width / 36),
        _buildListItemText(context),
      ],
    );
  }

  Widget _buildListItemText(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: AutoSizeText(
          text ?? "",
          style: dmsregular.copyWith(
            fontSize: fontSize ??
                FontSize.paragraph3(
                  context,
                ),
            color: SippoColor.darkgrey,
          ),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  Widget _buildDotBeforeText(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Padding(
      padding: EdgeInsets.only(
        top: startCrossAlignment ? height / 128 : 0,
      ),
      child: Image.asset(
        JobstopPngImg.dot,
        height: height / 120,
        color: SippoColor.primarycolor,
      ),
    );
  }
}
