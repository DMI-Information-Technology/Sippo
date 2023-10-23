import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/custom_app_controller/switch_status_controller.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';
import 'package:jobspot/sippo_data/model/image_resource_model/image_resource_model.dart';
import 'package:jobspot/utils/image_picker_service.dart';

class GalleryImageUploaderController extends ChangeNotifier {
  final _images = <CustomFileModel>[];
  List<ImageResourceModel>? _imagesResource;
  final overlayLoading = SwitchStatusController();

  List<CustomFileModel> get images => _images;

  void set imagesResource(List<ImageResourceModel>? value) {
    if (value == null) return;
    _imagesResource = value;
    notifyListeners();
  }

  List<ImageResourceModel> get imagesResource => _imagesResource ?? [];

  void uploadImages(List<CustomFileModel>? images) {
    if (images == null) return;
    _images.addAll(images);
    notifyListeners();
  }

  void cancelImageAt(int index) {
    if (index >= 0 || index < _images.length) {
      _images.removeAt(index);
      notifyListeners();
    }
  }

  ImageResourceModel? cancelImageResourceAt(int index) {
    ImageResourceModel? image;
    if (index >= 0 || index < _images.length) {
      image = _imagesResource?[index];
      _imagesResource?.removeAt(index);
      notifyListeners();
    }
    return image;
  }

  void insertImageResource(int index, ImageResourceModel? value) {
    if (_imagesResource != null && value != null) {
      _imagesResource?.insert(index, value);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _images.clear();
    _imagesResource = null;
    overlayLoading.dispose();
    super.dispose();
  }
}

class GalleryImageUploaderView extends StatefulWidget {
  const GalleryImageUploaderView({
    super.key,
    required this.onSaveTap,
    required this.onRemoveImage,
    this.title = '',
    this.imagesResource,
  });

  final List<ImageResourceModel>? imagesResource;
  final Future<bool> Function(List<CustomFileModel> images) onSaveTap;
  final String title;
  final Future<bool> Function(int? id, int index) onRemoveImage;

  @override
  State<GalleryImageUploaderView> createState() =>
      _GalleryImageUploaderViewState();
}

class _GalleryImageUploaderViewState extends State<GalleryImageUploaderView> {
  final _controller = GalleryImageUploaderController();

  @override
  void initState() {
    super.initState();
    _controller.imagesResource = widget.imagesResource?.toList();
    print(_controller.imagesResource);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScaffold(
      canPopOnLoading: false,
      controller: _controller.overlayLoading,
      appBar: AppBar(
        titleSpacing: 0.0,
        title: widget.title.isNotEmpty
            ? Text(
                widget.title,
                style: dmsmedium.copyWith(
                  fontSize: FontSize.title4(context),
                ),
              )
            : null,
      ),
      body: BodyWidget(
        isScrollable: true,
        paddingContent: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.paddingValue),
        ),
        child: SizedBox(
          width: context.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: context.fromHeight(CustomStyle.spaceBetween),
              ),
              Text(
                'Gallery Images',
                style: dmsbold.copyWith(
                  fontSize: FontSize.title5(context),
                ),
              ),
              ListenableBuilder(
                  listenable: _controller,
                  builder: (context, _) {
                    return GalleryImagesViewWidget(
                      imageCount: _controller.imagesResource.length,
                      imageBuilder: (context, index) {
                        final e = _controller.imagesResource[index];
                        if (e.url == null) return const SizedBox.shrink();
                        return SingleImageViewWidget.fromNetwork(
                          url: e.url,
                          onActionTap: () {
                            Get.dialog(
                              CustomAlertDialog(
                                title: 'confirm_remove_image'.tr,
                                description: 'confirm_remove_image_ask'.tr,
                                confirmBtnTitle: 'Remove',
                                onConfirm: () {
                                  Navigator.pop(context);
                                  _controller.overlayLoading.start();
                                  final image =
                                      _controller.cancelImageResourceAt(index);
                                  widget
                                      .onRemoveImage(image?.id, index)
                                      .then((done) {
                                    _controller.overlayLoading.pause();
                                    if (!done)
                                      _controller.insertImageResource(
                                        index,
                                        image,
                                      );
                                  });
                                },
                                onCancel: () => Navigator.pop(context),
                              ),
                            );
                          },
                        );
                      },
                      noImagesWidget: Text("No images found."),
                    );
                  }),
              Divider(
                  height: context.fromHeight(CustomStyle.spaceBetween),
                  thickness: 1.5),
              Text(
                'Uploaded Gallery Images',
                style: dmsbold.copyWith(
                  fontSize: FontSize.title5(context),
                ),
              ),
              ListenableBuilder(
                  listenable: _controller,
                  builder: (context, _) {
                    return GalleryImagesViewWidget(
                      imageCount: _controller.images.length,
                      imageBuilder: (context, index) {
                        final e = _controller.images[index];
                        if (e.isFileNull) return const SizedBox.shrink();
                        return SingleImageViewWidget.fromMemory(
                          bytes: e.bytes,
                          onActionTap: () => _controller.cancelImageAt(index),
                        );
                      },
                      lastWidget: _buildUploadImagesActionButtonWidget(context),
                    );
                  }),
            ],
          ),
        ),
        paddingBottom: EdgeInsets.all(
          context.fromWidth(CustomStyle.paddingValue),
        ),
        bottomScreen: ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              return CustomButton(
                onTapped: () => _onSaveTapped(context),
                text: 'Save',
                backgroundColor:
                    _controller.images.isEmpty ? Colors.grey : null,
              );
            }),
      ),
    );
  }

  InkWell _buildUploadImagesActionButtonWidget(BuildContext context) {
    return InkWell(
      onTap: () async {
        final images = await ImagePickerFile.pickMultiImageFromGallery(
          fieldName: 'images',
        );
        _controller.uploadImages(images);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black54,
          ),
          borderRadius: BorderRadius.circular(21),
        ),
        width: context.fromWidth(3.5),
        height: context.fromHeight(7.1),
        child: const FractionallySizedBox(
          heightFactor: 0.50,
          widthFactor: 0.50,
          child: CircleAvatar(
            child: Icon(
              Icons.add_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _onSaveTapped(BuildContext context) {
    if (_controller.images.isEmpty) {
      print('klmvlkdsmldvs');
      Get.snackbar(
        backgroundColor: Colors.grey[300],
        boxShadows: [boxShadow],
        'No Images Uploaded',
        'No new images found. Please pick some images and continue',
      );
      // ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      //   content: ListTile(
      //     title: Text('Title Title'),
      //     subtitle: Text('content content contentcontentcontentcontent content content content.'),
      //     contentPadding: EdgeInsets.zero,
      //   ),
      //   behavior: SnackBarBehavior.floating,
      //   padding: EdgeInsets.symmetric(
      //     horizontal: context.fromWidth(CustomStyle.paddingValue),
      //     vertical: context.fromHeight(CustomStyle.xxxl),
      //   ),
      //   backgroundColor: Colors.grey[300],
      //   dismissDirection: DismissDirection.up,
      //   duration: const Duration(milliseconds: 1500),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(25),
      //   ),
      //   margin: EdgeInsets.only(
      //     bottom: context.height - context.fromHeight(6),
      //     right: context.fromWidth(CustomStyle.s),
      //     left: context.fromWidth(CustomStyle.s),
      //   ),
      // ));

      return;
    }
    print('4444444444444444444');
    Get.dialog(
      CustomAlertDialog(
        title: 'upload_images'.tr,
        description: 'confirm_upload_image_ask'.tr,
        confirmBtnTitle: 'Continue',
        onConfirm: () {
          Navigator.pop(context);
          _controller.overlayLoading.start();
          widget.onSaveTap(_controller.images).then((done) {
            _controller.overlayLoading.pause();
            if (done) {
              Get.dialog(
                CustomAlertDialog(
                  title: 'upload_images'.tr,
                  description: 'upload_images_success_desc'.tr,
                  onConfirm: () {
                    Navigator.pop(context);

                    Navigator.pop(context);
                  },
                ),
              );
            } else {
              Get.dialog(
                CustomAlertDialog(
                  title: 'upload_images'.tr,
                  description: 'upload_images_field_desc'.tr,
                  onConfirm: () => Navigator.pop(context),
                ),
              );
            }
          });
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
  }
}

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
  })  : this._assets = assets,
        this._url = null,
        this._bytes = null,
        this.imageProviderType = ImageProviderType.assets;

  const SingleImageViewWidget.fromNetwork({
    super.key,
    required String? url,
    this.onActionTap,
    this.onTap,
  })  : this._url = url,
        this._assets = null,
        this._bytes = null,
        this.imageProviderType = ImageProviderType.network;

  const SingleImageViewWidget.fromMemory({
    super.key,
    required Uint8List? bytes,
    this.onActionTap,
    this.onTap,
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
        onTap: () {
          showOpenImageView();
          if (onTap != null) onTap!();
        },
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
