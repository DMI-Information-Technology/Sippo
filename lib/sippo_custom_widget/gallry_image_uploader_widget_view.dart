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

import 'gallery_image_widget_components.dart';

class GalleryImageUploaderController extends ChangeNotifier {
  late final List<CustomFileModel> _images;

  void initImages() => _images = [];
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

enum GalleryImageScreenType { company, visitor }

class GalleryImageScreenView extends StatefulWidget {
  const GalleryImageScreenView({
    super.key,
    required this.onSaveTap,
    required this.onRemoveImage,
    this.title = '',
    this.imagesResource,
  }) : this.galleryImageScreenType = GalleryImageScreenType.company;

  const GalleryImageScreenView.visitor({
    super.key,
    this.imagesResource,
    required this.title,
  })  : this.onSaveTap = null,
        this.onRemoveImage = null,
        galleryImageScreenType = GalleryImageScreenType.visitor;

  final List<ImageResourceModel>? imagesResource;
  final Future<bool> Function(List<CustomFileModel> images)? onSaveTap;
  final String title;
  final Future<bool> Function(int? id, int index)? onRemoveImage;
  final GalleryImageScreenType galleryImageScreenType;

  @override
  State<GalleryImageScreenView> createState() => _GalleryImageScreenViewState();
}

class _GalleryImageScreenViewState extends State<GalleryImageScreenView> {
  final _controller = GalleryImageUploaderController();

  @override
  void initState() {
    super.initState();
    if (isCompany) _controller.initImages();
    _controller.imagesResource = widget.imagesResource?.toList();
    print(_controller.imagesResource);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get isCompany =>
      widget.galleryImageScreenType == GalleryImageScreenType.company;

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
                'gallery_company_images'.tr,
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
                          onActionTap: isCompany
                              ? () =>
                                  _onActionRemoveResourceImage(context, index)
                              : null,
                        );
                      },
                      noImagesWidget: Text("No images found."),
                    );
                  }),
              if (isCompany) ...[
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
                        lastWidget:
                            _buildUploadImagesActionButtonWidget(context),
                      );
                    }),
              ]
            ],
          ),
        ),
        paddingBottom: isCompany
            ? EdgeInsets.all(
                context.fromWidth(CustomStyle.paddingValue),
              )
            : null,
        bottomScreen: isCompany
            ? ListenableBuilder(
                listenable: _controller,
                builder: (context, _) {
                  return CustomButton(
                    onTapped: () => _onSaveTapped(context),
                    text: 'Save',
                    backgroundColor:
                        _controller.images.isEmpty ? Colors.grey : null,
                  );
                })
            : null,
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

  void _onActionRemoveResourceImage(BuildContext context, int index) {
    Get.dialog(
      CustomAlertDialog(
        title: 'confirm_remove_image'.tr,
        description: 'confirm_remove_image_ask'.tr,
        confirmBtnTitle: 'Remove',
        onConfirm: () {
          Navigator.pop(context);
          _controller.overlayLoading.start();
          final image = _controller.cancelImageResourceAt(index);
          widget.onRemoveImage!(image?.id, index).then((done) {
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
      return;
    }
    Get.dialog(
      CustomAlertDialog(
        title: 'upload_images'.tr,
        description: 'confirm_upload_image_ask'.tr,
        confirmBtnTitle: 'Continue',
        onConfirm: () {
          Navigator.pop(context);
          _controller.overlayLoading.start();
          widget.onSaveTap!(_controller.images).then((done) {
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
