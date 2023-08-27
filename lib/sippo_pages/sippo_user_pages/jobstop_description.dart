import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../../JobGlobalclass/routes.dart';
import '../../JopController/JobDescriptionController/job_description_controller.dart';
import '../../sippo_custom_widget/list_item_text.dart';

class SippoJobDescription extends StatefulWidget {
  const SippoJobDescription({Key? key}) : super(key: key);

  @override
  State<SippoJobDescription> createState() => _SippoJobDescriptionState();
}

class _SippoJobDescriptionState extends State<SippoJobDescription> {
  List<String> jobInformation = [
    'Position'.tr,
    'Qualification'.tr,
    'Experience'.tr,
    'Job_Type'.tr,
    'Specialization'.tr,
  ];
  List<String> gallery = [JobstopPngImg.gallery1, JobstopPngImg.gallery2];
  final _jobDesController = Get.put(JobDescriptionController());
  int selected = 0;
  final bottomButtonScreen = [
    CustomButton(
      onTappeed: () => Get.toNamed(SippoRoutes.sippoloadapplicationcv),
      text: "apply".tr,
    ),
    BottomCompanyDetailsButtons(
      onApplyClicked: () => Get.toNamed(SippoRoutes.sippoloadapplicationcv),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;

    return Scaffold(
      body: BodyWidget(
        isScrollable: true,
        isTopScrollable: true,
        paddingTop: MediaQuery.of(context).viewPadding,
        paddingContent: MediaQuery.of(context).viewPadding.copyWith(
              left: context.fromWidth(CustomStyle.paddingValue),
              right: context.fromWidth(CustomStyle.paddingValue),
            ),
        topScreen: topJobDescription(),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => SizedBox(
                        width: width / 2.3,
                        child: CustomButton(
                          onTappeed: () {
                            _jobDesController.switchPageView();
                          },
                          text: "description".tr,
                          backgroundColor:
                              _jobDesController.changeDescriptionButtonColor(),
                        ),
                      ),
                    ),
                    Obx(
                      () => SizedBox(
                        width: width / 2.3,
                        child: CustomButton(
                          onTappeed: () {
                            _jobDesController.switchPageView();
                          },
                          text: "company".tr,
                          backgroundColor:
                              _jobDesController.changeCompanyButtonColor(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: context.fromHeight(CustomStyle.spaceBetween),
                ),
                Obx(
                  () => _jobDesController.selectedPageView == 0
                      ? detailsJobView()
                      : companyView(),
                ),
              ],
            ),
          ],
        ),
        paddingBottom:
            EdgeInsets.all(context.fromWidth(CustomStyle.paddingValue)),
        bottomScreen: Obx(
          () => bottomButtonScreen[_jobDesController.selectedPageView],
        ),
      ),
    );
  }

  Widget companyView() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._buildTextDetailsWidgets(
          context,
          "About_Company".tr,
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.\n\nAt vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas .\n\nNor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain."
              .tr,
        ),
        SizedBox(height: context.fromHeight(CustomStyle.huge2)),
        ..._buildTextDetailsWidgets(
          context,
          "Website".tr,
          "https://www.google.com".tr,
        ),
        SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
        ..._buildTextDetailsWidgets(
          context,
          "Industry".tr,
          "Internet product".tr,
        ),
        SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
        ..._buildTextDetailsWidgets(
          context,
          "Employee_size".tr,
          "132,121 Employees".tr,
        ),
        SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
        ..._buildTextDetailsWidgets(
          context,
          "Head_office".tr,
          "Mountain View, California, Amerika Serikat".tr,
        ),
        SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
        ..._buildTextDetailsWidgets(
          context,
          "Type".tr,
          "Multinational company".tr,
        ),
        SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
        ..._buildTextDetailsWidgets(
          context,
          "Since".tr,
          "1998".tr,
        ),
        SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
        ..._buildTextDetailsWidgets(
          context,
          "Specialization".tr,
          "Search technology, Web computing, Software and Online advertising"
              .tr,
        ),
        SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
        Text(
          "Company_Gallery".tr,
          style: dmsbold.copyWith(fontSize: 14),
        ),
        SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
        SizedBox(
          height: height / 7,
          child: ListView.builder(
            itemCount: gallery.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: width / 36),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  gallery[index],
                  fit: BoxFit.fill,
                  width: width / 2.3,
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: height / 64,
        ),
      ],
    );
  }

  List<Widget> _buildTextDetailsWidgets(
      BuildContext context, String title, String text) {
    return [
      Text(
        title,
        style: dmsbold.copyWith(fontSize: 14),
      ),
      SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
      Text(
        text,
        style: dmsregular.copyWith(
          fontSize: FontSize.title6(context),
          color: Jobstopcolor.darkgrey,
        ),
        maxLines: 15,
        overflow: TextOverflow.ellipsis,
      ),
    ];
  }

  Widget detailsJobView() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Salary",
              style: dmsregular.copyWith(
                  fontSize: 14, color: Jobstopcolor.primarycolor),
            ),
            Text(
              "Job Type",
              style: dmsregular.copyWith(
                  fontSize: 14, color: Jobstopcolor.primarycolor),
            ),
            Text(
              "Postion",
              style: dmsregular.copyWith(
                fontSize: 14,
                color: Jobstopcolor.primarycolor,
              ),
            ),
          ],
        ),
        SizedBox(
          height: height / 40,
        ),
        Text(
          "Job_Description".tr,
          style: dmsbold.copyWith(fontSize: 14),
        ),
        SizedBox(
          height: height / 76,
        ),
        Text(
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem ..."
              .tr,
          style:
              dmsregular.copyWith(fontSize: 12, color: Jobstopcolor.darkgrey),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: height / 36,
        ),
        Text(
          "Requirements".tr,
          style: dmsbold.copyWith(fontSize: 14),
        ),
        SizedBox(
          height: height / 66,
        ),
        ListTextItem(
          text: "Sed ut perspiciatis unde omnis iste natus error sit.".tr,
          startCrossAlignment: true,
        ),
        SizedBox(
          height: height / 66,
        ),
        ListTextItem(
          text:
              "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur & adipisci velit."
                  .tr,
          startCrossAlignment: true,
        ),
        SizedBox(
          height: height / 66,
        ),
        ListTextItem(
          text:
              "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit."
                  .tr,
          startCrossAlignment: true,
        ),
        SizedBox(
          height: height / 66,
        ),
        ListTextItem(
          text:
              "Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur"
                  .tr,
          startCrossAlignment: true,
        ),
        SizedBox(
          height: height / 36,
        ),
        Text(
          "Location".tr,
          style: dmsbold.copyWith(fontSize: 14),
        ),
        SizedBox(
          height: height / 66,
        ),
        Text(
          "Overlook Avenue, Belleville, NJ, USA".tr,
          style:
              dmsregular.copyWith(fontSize: 12, color: Jobstopcolor.darkgrey),
        ),
        SizedBox(
          height: height / 66,
        ),
        Container(
          height: height / 5,
          width: width / 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(
            JobstopPngImg.locationmap,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: height / 36,
        ),
        AutoSizeText(
          "Informations".tr,
          style: dmsbold.copyWith(fontSize: FontSize.title5(context)),
        ),
        SizedBox(
          height: height / 46,
        ),
        for (var info in jobInformation) ...[
          AutoSizeText(
            info,
            style: dmsmedium.copyWith(
              fontSize: FontSize.title6(context),
              color: Jobstopcolor.primarycolor,
            ),
          ),
          SizedBox(
            height: height / 22,
            child: InputField(hintText: "job"),
          ),
          SizedBox(
            height: height / 46,
          ),
        ],
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

class BottomCompanyDetailsButtons extends StatelessWidget {
  const BottomCompanyDetailsButtons({
    super.key,
    this.onFavClicked,
    required this.onApplyClicked,
  });

  final void Function()? onFavClicked;
  final void Function() onApplyClicked;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: height / 15,
          width: height / 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Jobstopcolor.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                color: Jobstopcolor.shedo,
              )
            ],
          ),
          child: InkWell(
            onTap: onFavClicked,
            child: Padding(
              padding: EdgeInsets.all(width / 28),
              child: Image.asset(
                JobstopPngImg.order,
                color: Jobstopcolor.orenge,
              ),
            ),
          ),
        ),
        SizedBox(width: width / 36),
        Flexible(
          child: CustomButton(
            onTappeed: () => onApplyClicked(),
            text: "Apply Now".tr,
          ),
        ),
      ],
    );
  }
}
