import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/gallery_image_widget_components.dart';
import 'package:jobspot/sippo_custom_widget/gallry_image_uploader_widget_view.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';

class ShowAboutCompaniesDetails extends StatelessWidget {
  const ShowAboutCompaniesDetails({super.key, this.company})
      : this.gallery = const [JobstopPngImg.gallery1, JobstopPngImg.gallery2];
  final CompanyDetailsModel? company;
  final List<String> gallery;

  @override
  Widget build(BuildContext context) {
    print(company?.images);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildTextDetailsWidgets(
          context,
          "About_Company".tr,
          company?.bio ?? '',
        ),
        _buildTextDetailsWidgets(
          context,
          "phone_number".tr,
          company?.phone ?? "",
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
          company?.locations
                  ?.where((e) => e.locationAddress != null)
                  .map((e) => e.locationAddress?.name ?? '')
                  .join(", ") ??
              "",
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
        if (company?.images?.isNotEmpty == true) ...[
          Text(
            "Company_Gallery".tr,
            style: dmsbold.copyWith(fontSize: 14),
          ),
          SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
          SizedBox(
            height: context.fromHeight(7.1),
            child: ListView.separated(
              itemCount: company?.images?.take(4).length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final length = company?.images?.length ?? 0;
                final images = company?.images;
                final isShowMoreImages = index == 3 && length > 4;
                return SingleImageViewWidget.fromNetwork(
                  url: images?[index].url,
                  isShowMoreImage: isShowMoreImages,
                  onTap: isShowMoreImages
                      ? () {
                          Get.to(
                            () => GalleryImageScreenView.visitor(
                              title: '${company?.name} ${'albums'.tr}',
                              imagesResource: images,
                            ),
                          );
                        }
                      : null,
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                width: context.fromWidth(CustomStyle.spaceBetween),
              ),
            ),
          ),
        ] else
          const SizedBox.shrink(),
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
            mainAxisAlignment: MainAxisAlignment.start,
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
                  color: SippoColor.darkgrey,
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
