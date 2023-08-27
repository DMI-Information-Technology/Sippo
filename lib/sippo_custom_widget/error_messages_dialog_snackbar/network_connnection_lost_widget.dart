import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../JobGlobalclass/jobstopfontstyle.dart';
import '../../JobGlobalclass/text_font_size.dart';

class NetworkConnectionLostWidget extends StatelessWidget {
  const NetworkConnectionLostWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height / 25,
      decoration: BoxDecoration(
        color: Colors.black54,
      ),
      child: AutoSizeText(
        'network connection is lost',
        style: dmsregular.copyWith(
          color: Colors.redAccent,
          fontSize: FontSize.label3(context),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
