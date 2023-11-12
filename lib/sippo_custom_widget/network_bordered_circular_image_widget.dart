import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';

import '../JobGlobalclass/sippo_customstyle.dart';

class NetworkBorderedCircularImage extends StatelessWidget {
  const NetworkBorderedCircularImage({
    super.key,
    required this.imageUrl,
    this.size = 50,
    this.outerBorderColor,
    this.innerBorderColor,
    this.errorWidget,
    this.backgroundColor,
    this.outerBorderWidth,
    this.innerBorderWidth,
    this.placeholder,
  });

  final Widget Function(BuildContext context, String url)? placeholder;
  final Color? backgroundColor;
  final double size;
  final Color? outerBorderColor;
  final double? outerBorderWidth;
  final Color? innerBorderColor;
  final double? innerBorderWidth;
  final String imageUrl;
  final Widget Function(BuildContext context, String url, dynamic error)?
      errorWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: outerBorderColor ?? Colors.grey,
          width: outerBorderWidth ?? context.fromWidth(CustomStyle.xxxl),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: innerBorderColor ?? Colors.white,
            width: innerBorderWidth ?? context.fromWidth(CustomStyle.varyHuge),
          ),
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            width: size,
            height: size,
            errorWidget: errorWidget,
            placeholder: placeholder,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
