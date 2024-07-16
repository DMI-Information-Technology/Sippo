import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/ads_controller/ads_controller.dart';
import 'package:sippo/sippo_data/model/ads_model/ad_model.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
class AdsViewWidget extends StatefulWidget {
  const AdsViewWidget({super.key});

  @override
  State<AdsViewWidget> createState() => _AdsViewWidgetState();
}



// ... your other imports (JobstopPngImg, CustomStyle, dmsbold, FontSize, etc.)

class _AdsViewWidgetState extends State<AdsViewWidget> {
  final _controller = Get.put(AdsViewController());
  final _pageController = PageController(); // Use PageController

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final adItems = _controller.adItems;
      if (_controller.states.isLoading)
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.fromHeight(CustomStyle.paddingValue),
          ),
          child: Center(
            child: Lottie.asset(
              JobstopPngImg.loadingProgress,height: context.height / 6,
            ),
          ),
        );
      if (_controller.states.isError)
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.fromHeight(CustomStyle.paddingValue),
          ),
          child: Center(
            child: Text(
              _controller.states.message ?? "message_error_occurred".tr,
              style: dmsbold.copyWith(
                fontSize: FontSize.title4(context),
              ),
            ),
          ),
        );
      if (_controller.states.isSuccess) {
        if (adItems.isNotEmpty) {
          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 0.95,
                  clipBehavior: Clip.antiAlias,
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  height: context.height / 4.5,
                  onPageChanged: (index, reason) {
                    _pageController.animateToPage(
                      index,
                      duration:const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
                items: adItems.map(
                      (e) {
                    return AdsWidgetItem(
                      item: e,
                      onAdTapped: onAdItemTapped,
                    );
                  },
                ).toList(),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: adItems.length,
                effect: WormEffect(), // Choose your desired effect
              ),
            ],
          );
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.fromHeight(CustomStyle.paddingValue),
            ),
            child: Center(
              child: Text(
                'message_no_ds_found'.tr,
                style: dmsbold.copyWith(
                  fontSize: FontSize.title4(context),
                ),
              ),
            ),
          );
        }
      }
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.fromHeight(CustomStyle.paddingValue),
        ),
        child: Center(
          child: Text(
            'message_no_ds_found_reload'.tr,
            style: dmsbold.copyWith(
              fontSize: FontSize.title4(context),
            ),
          ),
        ),
      );
    });
  }

  // Make sure you have the onAdItemTapped function defined if it's being used
  void onAdItemTapped(item) {
    // Handle ad item tap
  }
}
  void onAdItemTapped(AdModel e) async {
    final url = e.url;
    if (url == null || !url.isURL) {
      print('_AdsViewWidgetState.build: invalid url.');
      return;
    }
    final uri = Uri.parse(e.url ?? '');
    try {
      if (!await launchUrl(uri)) {
        throw Exception('_AdsViewWidgetState.build: the url is not available.');
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }


class AdsWidgetItem extends StatelessWidget {
  const AdsWidgetItem({
    super.key,
    required this.item,
    required this.onAdTapped,
  });

  final AdModel item;
  final void Function(AdModel item) onAdTapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onAdTapped(item),
      child: Container(
        decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(
              item.image?.url ?? "",
            ),
          ),
        ),
      ),
    );
  }
}
