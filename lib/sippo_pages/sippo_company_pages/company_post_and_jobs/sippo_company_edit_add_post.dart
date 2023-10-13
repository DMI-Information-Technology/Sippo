import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/company_profile_controller/company_edit_add_post_controller.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../../../sippo_custom_widget/ConditionalWidget.dart';
import '../../../sippo_custom_widget/success_message_widget.dart';
import '../../../utils/validating_input.dart';

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
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    final newPostState = _controller.newPostState;
    return WillPopScope(
      onWillPop: () async {
        // Get.back(result: newPostState.isUpdated ? _controller.post : null);
        Get.back(result: newPostState.isUpdated);
        // return false;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.all(
                context.fromWidth(
                  CustomStyle.paddingValue,
                ),
              ),
              child: InkWell(
                onTap: () {
                  if (_controller.formKey.currentState?.validate() == true) {
                    _controller.onSaveSubmitted();
                  }
                },
                child: Text(
                  "Post",
                  style: dmsbold.copyWith(
                    fontSize: FontSize.title5(context),
                    color: Jobstopcolor.primarycolor,
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
                  "${_controller.isEditing ? "Edit" : "Add"} Post",
                  style: dmsbold.copyWith(
                      fontSize: FontSize.title3(context),
                      color: Jobstopcolor.primarycolor),
                ),
                SizedBox(height: height / 36),
                _buildCompanyHeaderPage(context),
                _buildLoadingProgress(context),
                SizedBox(height: height / 36),
                Obx(() => ConditionalWidget(
                      _controller.states.isSuccess,
                      data: _controller.states,
                      guaranteedBuilder: (context, data) =>
                          CardNotifyMessage.success(
                        state: data,
                        onCancelTap: () => _controller.successState(false),
                      ),
                    )),
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
                  "Post title",
                  style: dmsbold.copyWith(
                    fontSize: FontSize.label(context),
                    color: Jobstopcolor.primarycolor,
                  ),
                ),
                SizedBox(height: height / 46),
                InputBorderedField(
                  gController: _controller.newPostState.title,
                  hintText: "Write the title of your post here",
                  validator: (value) =>
                      ValidatingInput.validateEmptyField(value),
                ),
                SizedBox(height: height / 36),
                Text(
                  "Description",
                  style: dmsbold.copyWith(
                    fontSize: FontSize.label(context),
                    color: Jobstopcolor.primarycolor,
                  ),
                ),
                SizedBox(height: height / 46),
                InputBorderedField(
                  gController: _controller.newPostState.description,
                  verticalPaddingValue: context.fromHeight(CustomStyle.xxl),
                  hintText: "What do you want to talk about?",
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
              horizontal: context.fromWidth(CustomStyle.s),
              vertical: context.fromHeight(CustomStyle.xl)),
          bottomScreen: _buildControlBottomBar(context),
        ),
      ),
    );
  }

  Widget _buildLoadingProgress(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Obx(() => ConditionalWidget(
          _controller.states.isLoading,
          guaranteedBuilder: (__, _) => Column(
            children: [
              SizedBox(height: height / 36),
              const Center(child: CircularProgressIndicator()),
            ],
          ),
        ));
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

  Row _buildControlBottomBar(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.camera_alt_rounded,
          color: Jobstopcolor.primarycolor,
          size: context.fromHeight(CustomStyle.s),
        ),
        SizedBox(width: context.fromWidth(CustomStyle.s)),
        InkWell(
          onTap: () => _controller.uploadImage(),
          child: Image.asset(
            JobstopPngImg.galleryicon,
            height: context.fromHeight(CustomStyle.l),
            color: Jobstopcolor.primarycolor,
          ),
        ),
      ],
    );
  }

  Row _buildCompanyHeaderPage(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: context.fromHeight(CustomStyle.m),
          backgroundImage: AssetImage(JobstopPngImg.photo),
        ),
        SizedBox(width: context.width / 36),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _controller.company.name ?? "unknown",
              style: dmsbold.copyWith(
                fontSize: FontSize.title6(context),
                color: Jobstopcolor.primarycolor,
              ),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.huge2)),
            Text(
              _controller.company.city ?? "unknown",
              style: dmsregular.copyWith(
                fontSize: FontSize.label(context),
                color: Jobstopcolor.darkgrey,
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
