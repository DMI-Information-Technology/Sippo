import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/sippo_custom_widget/ConditionalWidget.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../../JobGlobalclass/jobstopimges.dart';
import '../../JobGlobalclass/routes.dart';
import '../../JopController/AuthenticationController/sippo_signup_company_controller.dart';
import '../../custom_app_controller/google_map_view_controller.dart';
import '../../sippo_custom_widget/custom_drop_down_button.dart';
import '../../sippo_custom_widget/google_map_view_widget.dart';

class SippoLocationCompanySelector extends StatefulWidget {
  const SippoLocationCompanySelector({super.key});

  @override
  State<SippoLocationCompanySelector> createState() =>
      _SippoLocationCompanySelectorState();
}

class _SippoLocationCompanySelectorState
    extends State<SippoLocationCompanySelector> {
  final _myLocationController = TextEditingController();
  final netConnController = InternetConnectionService.instance;
  final _signUpCompanyController = SignUpCompanyController.instance;
  final googleMapViewController = GoogleMapViewController();
  final tempData = List.generate(
    12,
    (index) => 'Location Address ${index + 1}',
  );

  @override
  void initState() {
    super.initState();
    googleMapViewController.getCurrentLocation();
  }

  @override
  void dispose() {
    _myLocationController.dispose();
    googleMapViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return WillPopScope(
      onWillPop: () async {
        _signUpCompanyController.companyAddress = "";
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () {
              _signUpCompanyController.companyAddress = "";
              Get.back();
            },
            icon: Icon(Icons.arrow_back_rounded),
          ),
          title: Text("selecte_address".tr, style: dmsbold),
        ),
        body: BodyWidget(
          isScrollable: true,
          paddingContent: EdgeInsets.symmetric(
            vertical: width / 26,
            horizontal: width / 26,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Address City".tr,
                style: dmsbold.copyWith(fontSize: FontSize.title5(context)),
              ),
              CustomDropdownButton(
                textHint: 'Select Company Work Place',
                labelList: tempData,
                values: tempData,
                fillColor: Colors.white,
                onItemSelected: (value) async {
                  _myLocationController.text = value ?? "";
                  _signUpCompanyController.companyAddress =
                      _myLocationController.text;
                  print(value);
                },
                setInitialValue: false,
                initialValue: 'Tripoli, Ain-zara',
              ),
              SizedBox(
                height: height / 42,
              ),
              Obx(
                () => !netConnController.isConnected
                    ? _buildMessageNoConnectionToGetAddress(height)
                    : SizedBox(),
              ),
              GoogleMapViewWidget(
                controller: googleMapViewController,
                onMapLocationMarked: (latLang) {
                  _signUpCompanyController.setCordLocation(
                    lat: latLang.latitude,
                    long: latLang.longitude,
                  );
                },
              ),
              Obx(() => ConditionalWidget(
                    _signUpCompanyController.companyAddress.isNotEmpty,
                    guaranteedBuilder: (context, _) => ListTile(
                      title: _locationAddressNameTextBuilder(context),
                      subtitle: ListenableBuilder(
                        listenable: googleMapViewController,
                        builder: _coordinatesTextBuilder,
                      ),
                    ),
                  )),
              SizedBox(height: height / 256),
              Obx(
                () => CheckboxListTile(
                  title: Text(
                    "terms_policy_title".tr,
                    textAlign: TextAlign.start,
                    style: dmsbold.copyWith(fontSize: height / 42),
                  ),
                  subtitle: Text(
                    "accept_terms".tr,
                    style: dmsregular.copyWith(fontSize: height / 52),
                  ),
                  value: _signUpCompanyController.confirmOnPolicy,
                  onChanged: (value) {
                    _signUpCompanyController.toggleConfirmPolicy();
                  },
                  activeColor: Jobstopcolor.primarycolor,
                ),
              ),
            ],
          ),
          paddingBottom: EdgeInsets.all(
            context.fromWidth(CustomStyle.paddingValue),
          ),
          bottomScreen: CustomButton(
            onTapped: _onSubmitConfirm,
            text: "confirm".tr,
          ),
        ),
      ),
    );
  }

  Widget _locationAddressNameTextBuilder(context) {
    final addressName = _signUpCompanyController.companyAddress;
    return Text(
      addressName,
      style: dmsmedium,
    );
  }

  Widget _coordinatesTextBuilder(context, widget) {
    final markerPlace = googleMapViewController.markerPlace;
    return Text(
      "${markerPlace.position.latitude.toStringAsFixed(7)},"
      " ${markerPlace.position.longitude.toStringAsFixed(7)}",
      style: dmsregular,
    );
  }

  void _onSubmitConfirm() async {
    if (_signUpCompanyController.confirmOnPolicy &&
        _signUpCompanyController.companyAddress.isNotEmpty &&
        _signUpCompanyController.cordLocation.validateCords()) {
      Get.toNamed(SippoRoutes.identityverification);
    } else {
      _showBadConfirmDialog();
    }
  }

  void _showBadConfirmDialog() {
    Get.dialog(
      CustomAlertDialog(
        imageAsset: JobstopPngImg.policyaccepted,
        title: "accept_terms_msg".tr,
        description: "accept_terms_desc".tr,
        confirmBtnTitle: "ok".tr,
        onConfirm: () {
          Get.back();
        },
      ),
    );
  }

  Column _buildMessageNoConnectionToGetAddress(double height) {
    return Column(
      children: [
        Text(
          "bad_connection_get_address_msg".tr,
          style: dmsregular.copyWith(
            fontSize: height / 59,
            color: Jobstopcolor.red,
          ),
        ),
        SizedBox(
          height: height / 21,
        ),
      ],
    );
  }
}
