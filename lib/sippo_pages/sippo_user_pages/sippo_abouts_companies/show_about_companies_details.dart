import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';

import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';

class ShowAboutCompaniesDetails extends StatelessWidget {
  const ShowAboutCompaniesDetails({super.key, this.company})
      : this.gallery = const [JobstopPngImg.gallery1, JobstopPngImg.gallery2];
  final CompanyDetailsModel? company;
  final List<String> gallery;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextDetailsWidgets(
          context,
          "About_Company".tr,
          company?.bio ?? '',
        ),
        _buildTextDetailsWidgets(
          context,
          "Website".tr,
          company?.website ?? "",
        ),
        _buildTextDetailsWidgets(
          context,
          "Employee_size".tr,
          "${company?.employeesCount ?? ''} Employees",
        ),
        _buildTextDetailsWidgets(
          context,
          "Head_office".tr,
          company?.locations?.map((e) => e.address).join(", ") ?? "",
        ),
        _buildTextDetailsWidgets(
          context,
          "Type".tr,
          "Multinational company".tr,
        ),
        _buildTextDetailsWidgets(
          context,
          "Since".tr,
          company?.establishmentDate ?? '',
        ),
        _buildTextDetailsWidgets(
          context,
          "Specialization".tr,
          company?.specializations?.map((e) => e.name).join(", ") ?? "",
        ),
        Text(
          "Company_Gallery".tr,
          style: dmsbold.copyWith(fontSize: 14),
        ),
        SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
        SizedBox(
          height: context.height / 7,
          child: ListView.builder(
            itemCount: gallery.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: context.width / 36),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  gallery[index],
                  fit: BoxFit.fill,
                  width: context.width / 2.3,
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: context.height / 64,
        ),
      ],
    );
  }

  Widget _buildTextDetailsWidgets(
    BuildContext context,
    String title,
    String text,
  ) {
    return text.trim().isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                title,
                style: dmsbold.copyWith(fontSize: FontSize.title5(context)),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              AutoSizeText(
                text,
                style: dmsregular.copyWith(
                  fontSize: FontSize.title6(context),
                  color: Jobstopcolor.darkgrey,
                ),
                maxLines: 15,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            ],
          )
        : const SizedBox.shrink();
  }
}
