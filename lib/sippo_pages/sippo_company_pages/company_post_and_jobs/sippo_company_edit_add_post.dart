import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/company_profile_controller/company_edit_add_post_controller.dart';
import 'package:sippo/sippo_custom_widget/ConditionalWidget.dart';
import 'package:sippo/sippo_custom_widget/body_widget.dart';
import 'package:sippo/sippo_custom_widget/network_bordered_circular_image_widget.dart';
import 'package:sippo/sippo_custom_widget/success_message_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/utils/validating_input.dart';

class SippoCompanyEditAddPost extends StatefulWidget {
  const SippoCompanyEditAddPost({Key? key}) : super(key: key);

  @override
  State<SippoCompanyEditAddPost> createState() =>
      _SippoCompanyEditAddPostState();
}

class _SippoCompanyEditAddPostState extends State<SippoCompanyEditAddPost> {
  final _controller = CompanyEditAddPostController.instance;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    final newPostState = _controller.newPostState;
    return PopScope(
      onPopInvoked: (_) async {
        // Get.back(result: newPostState.isUpdated ? _controller.post : null);
        Get.back(result: newPostState.isUpdated);
        // return false;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              // padding: EdgeInsets.all(
              //   context.fromWidth(
              //     CustomStyle.paddingValue,
              //   ),
              // ),
              padding: EdgeInsets.symmetric(
                  horizontal: CustomStyle.paddingValue2, vertical: 10),
              child: InkWell(
                onTap: () {
                  if (_controller.formKey.currentState?.validate() == true) {
                    _controller.onSaveSubmitted();
                  }
                },
                child: Text(
                  "posted".tr,
                  style: dmsbold.copyWith(
                    fontSize: FontSize.title5(context),
                    color: SippoColor.primarycolor,
                  ),
                ),
              ),
            )
          ],
        ),
        body: BodyWidget(
          isScrollable: true,
          paddingContent: EdgeInsets.symmetric(
              horizontal: context.fromWidth(
            CustomStyle.paddingValue,
          )),
          child: Form(
            key: _controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${_controller.isEditing ? "edit".tr : "add".tr} ${'post'.tr}",
                  style: dmsbold.copyWith(
                      fontSize: FontSize.title3(context),
                      color: SippoColor.primarycolor),
                ),
                SizedBox(height: height / 36),
                _buildCompanyHeaderPage(context),
                _buildLoadingProgress(context),
                SizedBox(height: height / 36),
                Obx(() => ConditionalWidget(
                      _controller.states.isError,
                      data: _controller.states,
                      guaranteedBuilder: (_, data) => CardNotifyMessage.error(
                        state: data,
                        onCancelTap: () => _controller.errorState(false, ''),
                      ),
                    )),
                Obx(() => ConditionalWidget(
                      _controller.states.isWarning,
                      data: _controller.states,
                      guaranteedBuilder: (context, data) =>
                          CardNotifyMessage.warning(
                        state: data,
                        onCancelTap: () => _controller.warningState(false),
                      ),
                    )),
                Text(
                  "post_title".tr,
                  style: dmsbold.copyWith(
                    fontSize: FontSize.label(context),
                    color: SippoColor.primarycolor,
                  ),
                ),
                SizedBox(height: height / 46),
                InputBorderedField(
                  gController: _controller.newPostState.title,
                  hintText: "post_hint_text".tr,
                  validator: (value) =>
                      ValidatingInput.validateEmptyField(value),
                ),
                SizedBox(height: height / 36),
                Text(
                  "description".tr,
                  style: dmsbold.copyWith(
                    fontSize: FontSize.label(context),
                    color: SippoColor.primarycolor,
                  ),
                ),
                SizedBox(height: height / 46),
                InputBorderedField(
                  gController: _controller.newPostState.description,
                  verticalPaddingValue: context.fromHeight(CustomStyle.xxl),
                  hintText: "post_desc_hint_text".tr,
                  maxLine: 6,
                  validator: (value) =>
                      ValidatingInput.validateEmptyField(value),
                ),
                SizedBox(height: height / 46),
                _buildUrlImageView(context),
                _buildUploadImageView(context),
              ],
            ),
          ),
          paddingBottom: EdgeInsets.symmetric(
              horizontal: context.fromWidth(CustomStyle.xs),
              vertical: context.fromHeight(CustomStyle.xl)),
          bottomScreen: _buildControlBottomBar(context),
        ),
      ),
    );
  }

  Widget _buildLoadingProgress(BuildContext context) {
    return Obx(
      () => ConditionalWidget(false, isLoading: _controller.states.isLoading),
    );
  }

  Widget _buildUploadImageView(BuildContext _context) {
    return Obx(() {
      final image = _controller.newPostState.imageFile.file;
      return ConditionalWidget(
        image != null,
        data: image,
        guaranteedBuilder: (context, data) => data != null
            ? Stack(
                children: [
                  Image.file(data, fit: BoxFit.fill),
                  CloseCornerButton(
                    onTap: () {
                      _controller.newPostState.clearLoadedImage();
                    },
                    paddingValue: _context.fromWidth(CustomStyle.xxxl),
                  ),
                ],
              )
            : null,
      );
    });
  }

  Widget _buildUrlImageView(BuildContext _context) {
    return Obx(() {
      final image = _controller.newPostState.imageUrl.url;
      return ConditionalWidget(
        image != null,
        data: image,
        guaranteedBuilder: (_, data) => data != null
            ? Stack(
                children: [
                  CachedNetworkImage(imageUrl: data),
                  CloseCornerButton(
                    icon: Icons.delete,
                    backgroundColor: Colors.black.withOpacity(0.7),
                    iconColor: Colors.redAccent,
                    onTap: () {
                      _controller.newPostState.deleteUrlImage();
                    },
                    paddingValue: _context.fromWidth(CustomStyle.xxxl),
                  ),
                ],
              )
            : null,
      );
    });
  }

  Widget _buildControlBottomBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => _controller.uploadImage(),
          child: Image.asset(
            JobstopPngImg.galleryicon,
            height: context.fromHeight(CustomStyle.m),
            color: SippoColor.primarycolor,
          ),
        ),
      ],
    );
  }

  Row _buildCompanyHeaderPage(BuildContext context) {
    return Row(
      children: [
        NetworkBorderedCircularImage(
          imageUrl: _controller.company.profileImage?.url ?? '',
          size: context.fromWidth(8),
          outerBorderWidth: context.fromWidth(CustomStyle.huge2),
        ),
        SizedBox(width: context.width / 36),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _controller.company.name ?? "",
              style: dmsbold.copyWith(
                fontSize: FontSize.title6(context),
                color: SippoColor.primarycolor,
              ),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.huge2)),
            Text(
              _controller.company.city ?? "",
              style: dmsregular.copyWith(
                fontSize: FontSize.label(context),
                color: SippoColor.darkgrey,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class CloseCornerButton extends StatelessWidget {
  const CloseCornerButton({
    super.key,
    required this.onTap,
    this.backgroundColor,
    this.iconColor = Colors.white,
    this.iconSize,
    this.paddingValue,
    this.icon,
  });

  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? iconSize;
  final double? paddingValue;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: InkWell(
        onTap: onTap,
        child: ColoredBox(
          color: backgroundColor ?? Colors.black.withOpacity(0.7),
          child: Padding(
            padding: paddingValue != null
                ? EdgeInsets.all(paddingValue ?? 0)
                : EdgeInsets.zero,
            child: Icon(
              icon ?? Icons.close,
              color: iconColor ?? Colors.white,
              size: iconSize ?? context.fromHeight(CustomStyle.m),
            ),
          ),
        ),
      ),
    );
  }
}
