import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_controller/ads_controller/ads_controller.dart';
import 'package:jobspot/sippo_data/model/ads_model/ad_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AdsViewWidget extends StatefulWidget {
  const AdsViewWidget({super.key});

  @override
  State<AdsViewWidget> createState() => _AdsViewWidgetState();
}

class _AdsViewWidgetState extends State<AdsViewWidget> {
  final _controller = Get.put(AdsViewController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final adItems = _controller.adItems;
      if (_controller.states.isLoading)
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.fromHeight(CustomStyle.paddingValue),
          ),
          child: const Center(child: CircularProgressIndicator()),
        );
      if (_controller.states.isError)
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.fromHeight(CustomStyle.paddingValue),
          ),
          child: Center(
            child: Text(
              _controller.states.message ?? "Error occurred.",
              style: dmsbold.copyWith(
                fontSize: FontSize.title4(context),
              ),
            ),
          ),
        );
      if (_controller.states.isSuccess) {
        if (adItems.isNotEmpty) {
          return CarouselSlider(
            options: CarouselOptions(
              clipBehavior: Clip.antiAlias,
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              height: context.height / 4.5,
            ),
            items: adItems.map(
              (e) {
                return AdsWidgetItem(
                  adItem: e,
                  onAdTapped: onAdItemTapped,
                );
              },
            ).toList(),
          );
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.fromHeight(CustomStyle.paddingValue),
            ),
            child: Center(
              child: Text(
                'No Ads Found',
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
            'No Ads Found, Reload the Page',
            style: dmsbold.copyWith(
              fontSize: FontSize.title4(context),
            ),
          ),
        ),
      );
    });
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
}

class AdsWidgetItem extends StatelessWidget {
  const AdsWidgetItem(
      {super.key, required this.adItem, required this.onAdTapped});

  final AdModel adItem;
  final void Function(AdModel item) onAdTapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onAdTapped(adItem),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            context.fromWidth(CustomStyle.xs),
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(
              adItem.image?.url ?? "",
            ),
          ),
        ),
      ),
    );
  }
}