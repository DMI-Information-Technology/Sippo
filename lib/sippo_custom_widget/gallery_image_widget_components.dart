import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';

import '../JobGlobalclass/sippo_customstyle.dart';

class GalleryImagesViewWidget extends StatelessWidget {
  const GalleryImagesViewWidget({
    super.key,
    required this.imageBuilder,
    required this.imageCount,
    this.lastWidget,
    this.noImagesWidget = const SizedBox.shrink(),
  });

  final int imageCount;
  final Widget Function(BuildContext context, int index) imageBuilder;
  final Widget? lastWidget;
  final Widget noImagesWidget;

  @override
  Widget build(BuildContext context) {
    return imageCount == 0 && lastWidget == null
        ? Center(
            child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.fromHeight(CustomStyle.spaceBetween),
            ),
            child: noImagesWidget,
          ))
        : SizedBox(
            width: context.width,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              runSpacing: context.fromHeight(CustomStyle.huge),
              spacing: context.fromWidth(CustomStyle.xxl),
              alignment: WrapAlignment.start,
              children: [
                ...List.generate(
                  imageCount,
                  (index) => imageBuilder(context, index),
                ).toList(),
                if (lastWidget != null) lastWidget!,
              ],
            ),
          );
  }
}

enum ImageProviderType { memory, assets, network }

class SingleImageViewWidget extends StatelessWidget {
  const SingleImageViewWidget({
    super.key,
    required String? assets,
    this.onActionTap,
    this.onTap,
    this.isShowMoreImage = false,
  })  : this._assets = assets,
        this._url = null,
        this._bytes = null,
        this.imageProviderType = ImageProviderType.assets;

  const SingleImageViewWidget.fromNetwork({
    super.key,
    required String? url,
    this.onActionTap,
    this.onTap,
    this.isShowMoreImage = false,
  })  : this._url = url,
        this._assets = null,
        this._bytes = null,
        this.imageProviderType = ImageProviderType.network;

  const SingleImageViewWidget.fromMemory({
    super.key,
    required Uint8List? bytes,
    this.onActionTap,
    this.onTap,
    this.isShowMoreImage = false,
  })  : this._url = null,
        this._assets = null,
        this._bytes = bytes,
        this.imageProviderType = ImageProviderType.memory;

  final VoidCallback? onActionTap;
  final String? _assets;
  final String? _url;
  final Uint8List? _bytes;
  final ImageProviderType imageProviderType;
  final VoidCallback? onTap;
  final bool isShowMoreImage;
  static const imageTag = 'default_image_tag';

  ImageProvider _buildImageProvider() {
    return switch (imageProviderType) {
      ImageProviderType.memory => MemoryImage(_bytes!),
      ImageProviderType.assets => AssetImage(_assets!) as ImageProvider,
      ImageProviderType.network => CachedNetworkImageProvider(_url!),
    };
  }

  void showOpenImageView() {
    switch (imageProviderType) {
      case ImageProviderType.memory:
        Get.to(
          () => OpenImageView.fromMemory(
            heroTag: imageTag,
            bytes: _bytes,
          ),
        );
      case ImageProviderType.assets:
        Get.to(
          () => OpenImageView(
            heroTag: imageTag,
            assets: _assets,
          ),
        );
      case ImageProviderType.network:
        Get.to(
          () => OpenImageView.fromNetwork(
            heroTag: imageTag,
            url: _url,
          ),
        );
    }
  }

  bool get isAsset => imageProviderType == ImageProviderType.assets;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imageTag,
      child: InkWell(
        onTap: onTap ?? showOpenImageView,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.black54,
                ),
                borderRadius: BorderRadius.circular(21),
                image: DecorationImage(
                  image: isAsset
                      ? _buildImageProvider() as AssetImage
                      : _buildImageProvider(),
                  fit: BoxFit.cover,
                ),
              ),
              width: context.fromWidth(3.5),
              height: context.fromHeight(7.1),
            ),
            if (onActionTap != null)
              Positioned.directional(
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  radius: context.fromWidth(25),
                  child: InkWell(
                    onTap: onActionTap,
                    child: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  ),
                ),
                end: 5,
                top: 5,
                textDirection: TextDirection.ltr,
              ),
            if (isShowMoreImage)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black54,
                  ),
                  borderRadius: BorderRadius.circular(21),
                  color: Colors.black54,
                ),
                width: context.fromWidth(3.5),
                height: context.fromHeight(7.1),
                alignment: Alignment.center,
                child: Text(
                  'show_more'.tr,
                  style: dmsmedium.copyWith(color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              )
          ],
        ),
      ),
    );
  }
}

class OpenImageView extends StatelessWidget {
  final Uint8List? bytes;
  final String? url;
  final String heroTag;
  final String? assets;

  const OpenImageView.fromNetwork({
    Key? key,
    required this.url,
    required this.heroTag,
  })  : this.bytes = null,
        assets = null,
        super(key: key);

  const OpenImageView.fromMemory({
    Key? key,
    required this.bytes,
    required this.heroTag,
  })  : url = null,
        assets = null,
        super(key: key);

  const OpenImageView({
    Key? key,
    required this.assets,
    required this.heroTag,
  })  : url = null,
        bytes = null,
        super(key: key);

  Widget _buildImage() {
    if (url != null)
      return CachedNetworkImage(imageUrl: url!, fit: BoxFit.cover);
    if (bytes != null) return Image.memory(bytes!, fit: BoxFit.cover);
    if (assets != null) return Image.asset(assets!, fit: BoxFit.cover);
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black87),
      body: Center(
        child: Hero(
          tag: heroTag,
          child: _buildImage(),
        ),
      ),
    );
  }
}
