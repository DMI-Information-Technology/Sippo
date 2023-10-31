import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_controller/sippo_search_controller/user_filter_search.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/network_bordered_circular_image_widget.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

class SippoSearchJobsSpecializationsFilter extends StatefulWidget {
  const SippoSearchJobsSpecializationsFilter({super.key});

  @override
  State<SippoSearchJobsSpecializationsFilter> createState() =>
      _SippoSearchJobsSpecializationsFilterState();
}

class _SippoSearchJobsSpecializationsFilterState
    extends State<SippoSearchJobsSpecializationsFilter> {
  final _controller = SippoFilterSearchController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BodyWidget(
        paddingContent: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.paddingValue),
          vertical: context.fromHeight(CustomStyle.paddingValue),
        ),
        paddingTop: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.paddingValue),
        ),
        topScreen: _buildTopSearchBar(context),
        child: _buildSpecializationsGridView(context),
      ),
    );
  }

  Widget _buildTopSearchBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InputBorderedField(
            verticalPaddingValue: 0.0,
            hintText: 'search_on_specializations'.tr,
            hintStyle: TextStyle(
              fontSize: FontSize.title6(context),
            ),
            prefixIcon: Icon(Icons.search_rounded),
            onTextChanged: (value) {
              _controller.filterSearchState.specializationsSearch = value;
            },
          ),
        ),
        SizedBox(
          width: context.fromWidth(CustomStyle.spaceBetween),
        ),
        FilterButtonWidget(
          onTap: () {
            _controller.filterSearchState.specializationsSearchController.text =
                _controller.filterSearchState.specialization.name ?? '';
            Get.back();
          },
        )
      ],
    );
  }

  Widget _buildSpecializationsGridView(BuildContext context) {
    return Obx(() {
      final searchKey = _controller.filterSearchState.specializationsSearch;
      print(searchKey);
      final data =
          _controller.filterSearchState.filteredSpecializations(searchKey);
      print(data);
      return SizedBox(
        width: context.width,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 2 / 2.5,
          ),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                _controller.filterSearchState.specialization = data[index];

              },
              child: Obx(() {
                final specialization =
                    _controller.filterSearchState.specialization;
                return RoundedBorderRadiusCardWidget(
                  color: specialization == data[index]
                      ? Jobstopcolor.primarycolor
                      : Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NetworkBorderedCircularImage(
                        imageUrl: data[index].image?.url ?? '',
                        size: context.height / 12,
                        backgroundColor: Colors.white,
                        outerBorderWidth: 0.0,
                      ),
                      SizedBox(
                        height: context.fromHeight(CustomStyle.spaceBetween),
                      ),
                      AutoSizeText(
                        data[index].name ?? '',
                        style: TextStyle(
                          color: specialization == data[index]
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
          },
        ),
      );
    });
  }
}
