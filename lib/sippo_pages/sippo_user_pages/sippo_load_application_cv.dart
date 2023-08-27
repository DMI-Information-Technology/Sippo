import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/JobDescriptionController/job_description_controller.dart';

import '../../JobGlobalclass/sippo_customstyle.dart';
import '../../sippo_custom_widget/body_widget.dart';
import '../../sippo_custom_widget/circular_image.dart';
import '../../sippo_custom_widget/file_upload_widget.dart';
import '../../sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import '../../sippo_custom_widget/widgets.dart';
import '../../sippo_themes/themecontroller.dart';
import 'jobstop_success.dart';

class SippoLoadApplicationCV extends StatefulWidget {
  const SippoLoadApplicationCV({Key? key}) : super(key: key);

  @override
  State<SippoLoadApplicationCV> createState() => _SippoLoadApplicationCVState();
}

class _SippoLoadApplicationCVState extends State<SippoLoadApplicationCV> {
  TextEditingController information = TextEditingController();
  final themedata = Get.put(JobstopThemecontroler());
  final _loadCv = JobDescriptionController.instance;
  final LoadingOverlayController loadingController = LoadingOverlayController();

  @override
  void dispose() {
    loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScaffold(
      controller: loadingController,
      body: BodyWidget(
        isScrollable: true,
        isTopScrollable: true,
        paddingTop: MediaQuery.of(context).viewPadding,
        paddingContent: MediaQuery.of(context).viewPadding.copyWith(
              left: context.fromWidth(CustomStyle.paddingValue),
              right: context.fromWidth(CustomStyle.paddingValue),
            ),
        topScreen: topJobDescription(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.fromWidth(CustomStyle.paddingValue),
            vertical: context.fromHeight(CustomStyle.xxl),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload CV".tr,
                style: dmsbold.copyWith(
                  fontSize: FontSize.title5(context),
                  color: Jobstopcolor.primarycolor,
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.huge)),
              Text(
                "Add your CV/Resume to apply for a job".tr,
                style: dmsregular.copyWith(
                  fontSize: FontSize.label(context),
                  color: Jobstopcolor.darkgrey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: context.fromHeight(CustomStyle.l),
              ),
              Obx(
                () => FileUploadWidget(
                  // isJobApplied: true,
                  title: 'Upload your CV',
                  onUploadTapped: () async {
                    loadingController.loading = true;
                    await _loadCv.uploadCvFile();
                    Future.delayed(
                      Duration(seconds: 3),
                      () => loadingController.loading = false,
                    );
                  },
                  onDeletedFile: () async {
                    await _loadCv.removeCvFile();
                  },
                  isUploaded: !_loadCv.isCvJobApplyNull,
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.l)),
              Text(
                "Informations".tr,
                style: dmsbold.copyWith(fontSize: FontSize.title5(context)),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.l)),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      color: Jobstopcolor.greyyy,
                    )
                  ],
                ),
                child: TextField(
                  controller: information,
                  style: dmsregular.copyWith(
                    fontSize: FontSize.label(context),
                    color: Jobstopcolor.primarycolor,
                  ),
                  cursorColor: Jobstopcolor.grey,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Jobstopcolor.white,
                    filled: true,
                    hintText:
                        "Explain why you are the right person for this job".tr,
                    hintStyle: dmsregular.copyWith(
                      fontSize: FontSize.label(context),
                      color: Jobstopcolor.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        paddingBottom:
            EdgeInsets.all(context.fromHeight(CustomStyle.paddingValue)),
        bottomScreen: CustomButton(
          onTappeed: () {
            Get.to(() => const JobSuccess());
          },
          text: 'Apply Now'.tr,
        ),
      ),
    );
  }

  Widget _buildTopInformationApplication(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Stack(
      children: [
        Container(
          height: height / 4.5,
          color: Jobstopcolor.backgroud,
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: height / 7,
            width: width / 1,
            color: Jobstopcolor.greyyy,
            child: Column(
              children: [
                SizedBox(
                  height: context.fromHeight(CustomStyle.s),
                ),
                Text(
                  "UI/UX Designer",
                  style: dmsbold.copyWith(
                      fontSize: FontSize.title5(context),
                      color: Jobstopcolor.primarycolor),
                ),
                SizedBox(
                  height: context.fromHeight(CustomStyle.xxxl),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.fromWidth(CustomStyle.s),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Google",
                        style: dmsregular.copyWith(
                            fontSize: FontSize.title5(context),
                            color: Jobstopcolor.primarycolor),
                      ),
                      Image.asset(
                        JobstopPngImg.dot,
                        height: context.fromHeight(CustomStyle.huge2),
                      ),
                      Text(
                        "California",
                        style: dmsregular.copyWith(
                            fontSize: FontSize.title5(context),
                            color: Jobstopcolor.primarycolor),
                      ),
                      Image.asset(
                        JobstopPngImg.dot,
                        height: context.fromHeight(CustomStyle.huge2),
                      ),
                      Text(
                        "1 day ago",
                        style: dmsregular.copyWith(
                            fontSize: FontSize.title5(context),
                            color: Jobstopcolor.primarycolor),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 30,
          right: 30,
          child: CircularImage(
            JobstopPngImg.google,
            backgroundColor: Jobstopcolor.secondary,
            size: width / 4.5,
            paddingValue: width / 38,
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Jobstopcolor.backgroud,
      actions: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image.asset(JobstopPngImg.dots),
        ),
      ],
    );
  }

  Widget topJobDescription() {
    return Stack(
      children: [
        _setBackgroundStack(),
        _buildBottomDetailsJobStack(),
        _buildTopImageDetailsJobStack(),
      ],
    );
  }

  Widget _buildTopImageDetailsJobStack() {
    return Positioned(
      width: context.width,
      top: 0,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.back(),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 40,
            backgroundColor: Jobstopcolor.sky,
            child: Image.asset(
              JobstopPngImg.google,
              height: context.height / 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomDetailsJobStack() {
    return Positioned(
      bottom: 0,
      child: Container(
        height: context.height / 7,
        width: context.width / 1,
        color: Jobstopcolor.greyyy,
        child: Column(
          children: [
            SizedBox(
              height: context.height / 22,
            ),
            Text(
              "UI/UX Designer",
              style: dmsbold.copyWith(
                  fontSize: 16, color: Jobstopcolor.primarycolor),
            ),
            SizedBox(
              height: context.height / 66,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width / 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Google",
                    style: dmsregular.copyWith(
                      fontSize: 16,
                      color: Jobstopcolor.primarycolor,
                    ),
                  ),
                  Image.asset(
                    JobstopPngImg.dot,
                    height: context.height / 96,
                  ),
                  Text(
                    "California",
                    style: dmsregular.copyWith(
                      fontSize: 16,
                      color: Jobstopcolor.primarycolor,
                    ),
                  ),
                  Image.asset(
                    JobstopPngImg.dot,
                    height: context.height / 96,
                  ),
                  Text(
                    "1 day ago",
                    style: dmsregular.copyWith(
                      fontSize: 16,
                      color: Jobstopcolor.primarycolor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _setBackgroundStack() {
    return Container(
      width: context.width,
      height: context.height / 3.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(JobstopPngImg.backgroundProf),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
