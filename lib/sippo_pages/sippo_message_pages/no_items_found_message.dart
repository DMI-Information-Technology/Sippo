import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';

enum NotFoundMessageType {
  jobs,
  posts,
  companies,
  users,
  application,
  notification,
  none
}

class NoItemsFoundMessageWidget extends StatelessWidget {
  NoItemsFoundMessageWidget({
    super.key,
    this.title = null,
    this.description = null,
    this.alignmentFromStart = false,
  });

  NoItemsFoundMessageWidget.posts({
    super.key,
    this.alignmentFromStart = false,
  }) {
    setTextMessages(NotFoundMessageType.posts);
  }

  NoItemsFoundMessageWidget.jobs({
    super.key,
    this.alignmentFromStart = false,
  }) {
    setTextMessages(NotFoundMessageType.jobs);
  }

  NoItemsFoundMessageWidget.users({
    super.key,
    this.alignmentFromStart = false,
  }) {
    setTextMessages(NotFoundMessageType.users);
  }

  NoItemsFoundMessageWidget.companies({
    super.key,
    this.alignmentFromStart = false,
  }) {
    setTextMessages(NotFoundMessageType.companies);
  }  NoItemsFoundMessageWidget.application({
    super.key,
    this.alignmentFromStart = false,
  }) {
    setTextMessages(NotFoundMessageType.application);
  }  NoItemsFoundMessageWidget.notification({
    super.key,
    this.alignmentFromStart = false,
  }) {
    setTextMessages(NotFoundMessageType.notification);
  }

  late final String? title;
  late final String? description;
  final bool alignmentFromStart;

  void setTextMessages(NotFoundMessageType type) {
    switch (type) {
      case NotFoundMessageType.jobs:
        title = 'no_jobs_found_title'.tr;
        description = "$title. ${'reload_page_message'.tr}";
      case NotFoundMessageType.posts:
        title = 'no_posts_found_title'.tr;
        description = "$title. ${'reload_page_message'.tr}";
      case NotFoundMessageType.companies:
        title = 'no_companies_found_title'.tr;
        description = "$title. ${'reload_page_message'.tr}";
      case NotFoundMessageType.users:
        title = 'no_users_found_title'.tr;
        description = "$title. ${'reload_page_message'.tr}";
      case NotFoundMessageType.none:
      case NotFoundMessageType.application:
        title = 'no_application_found_title'.tr;
        description = "$title. ${'reload_page_message'.tr}";
      case NotFoundMessageType.notification:
        title = 'no_notification_found_title'.tr;
        description = "$title. ${'reload_page_message'.tr}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: alignmentFromStart
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          Text(
            title ?? 'no_items_found_title'.tr,
            style: dmsbold.copyWith(
              color: SippoColor.primarycolor,
              fontSize: FontSize.title3(context),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: context.fromHeight(CustomStyle.xxxl),
          ),
          Text(
            description ??
                "${'no_items_found_title'.tr}. ${'reload_page_message'.tr}",
            style: dmsmedium.copyWith(
              fontSize: FontSize.paragraph(context),
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
