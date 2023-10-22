import 'package:flutter/material.dart';
import 'package:jobspot/sippo_custom_widget/company_post_widget.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_post_model.dart';

class SippoPostDescription extends StatelessWidget {
  const SippoPostDescription({super.key, this.post, this.company});

  final CompanyDetailsModel? company;
  final CompanyDetailsPostModel? post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: PostWidget(
          authorName: company?.name ?? '',
          timeAgo: '21 minutes ago',
          postTitle: post?.title ?? "",
          postContent: post?.body ?? "",
          imageUrl: post?.image?.url,
        ),
      ),
    );
  }
}
