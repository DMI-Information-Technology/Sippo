import 'package:flutter/material.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/sippo_custom_widget/rounded_border_radius_card_widget.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/sippo_customstyle.dart';
import '../JobGlobalclass/text_font_size.dart';
import '../sippo_data/model/notification/notification_model.dart';
import 'network_bordered_circular_image_widget.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({
    super.key,
    required this.onTap,
    this.notification,
    required this.onActionTap,
  });

  final void Function() onTap;
  final BaseNotificationModel? notification;
  final void Function() onActionTap;

  @override
  Widget build(BuildContext context) {
    return RoundedBorderRadiusCardWidget(
      color: notification?.isRead != true ? SippoColor.lightprimary4 : null,
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.top,
        horizontalTitleGap: 0.0,
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0.0,
        title: Text(
          notification?.title ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification?.body ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: context.fromHeight(CustomStyle.huge)),
            Text(
              notification?.date ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: dmsregular.copyWith(
                fontSize: FontSize.label(context),
              ),
            ),
          ],
        ),
        leading: NetworkBorderedCircularImage(
          imageUrl: notification?.image?.url ?? '',
          size: context.fromHeight(18),
          outerBorderColor: Colors.transparent,
          outerBorderWidth: context.fromWidth(CustomStyle.huge),
          errorWidget: (_, __, ___) => Image.asset(JobstopPngImg.sippoLogo),
        ),
        trailing: InkWell(
          onTap: onActionTap,
          child: Icon(
            Icons.more_vert_rounded,
            color: Colors.black87,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
