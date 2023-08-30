import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';

import '../../JobGlobalclass/jobstopfontstyle.dart';
import '../../JobGlobalclass/text_font_size.dart';

class NetworkStatusNonWidget extends StatelessWidget {
  const NetworkStatusNonWidget({
    super.key,
    this.color = Colors.black87,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Container(
      alignment: Alignment.center,
      width: width,
      height: context.fromHeight(CustomStyle.connectionLostHeight),
      decoration: BoxDecoration(
        color: color,
      ),
      child: AutoSizeText(
        'network connection is lost',
        style: dmsregular.copyWith(
          color: Colors.red,
          fontSize: FontSize.label3(context),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
