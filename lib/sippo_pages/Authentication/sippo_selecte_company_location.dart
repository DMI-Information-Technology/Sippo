import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../../JobGlobalclass/jobstopimges.dart';
import '../../JobGlobalclass/routes.dart';
import '../../JobServices/locator_service.dart';
import '../../JopController/AuthenticationController/sippo_signup_company_controller.dart';
import '../../JopController/ConnectivityController/internet_connection_controller.dart';
import '../../utils/helper.dart';

class SippoLocationCompanySelector extends StatefulWidget {
  const SippoLocationCompanySelector({super.key});

  @override
  State<SippoLocationCompanySelector> createState() =>
      _SippoLocationCompanySelectorState();
}

class _SippoLocationCompanySelectorState
    extends State<SippoLocationCompanySelector> {
  final _myLocationController = TextEditingController();
  final netConnController = InternetConnectionController.instance;
  final _signUpCompanyController = SignUpCompanyController.instance;

  @override
  void initState() {
    super.initState();
    setLocation();
  }

  @override
  void dispose() {
    _myLocationController.dispose();
    super.dispose();
  }

  Future<void> setLocation() async {
    if (netConnController.isConnected) {
      final myLocation = await _detectedMyLocation();
      print("setLocation myLocation==null? ${myLocation == null}");
      if (myLocation == null) return;
      final myAddress = await LocatorService.getMyAddress(
        myLocation.latitude,
        myLocation.longitude,
      );
      print("setLocation myAddress==null? ${myAddress == null}");
      if (myAddress == null) return;

      String address = LocatorService.filterAddress(myAddress);
      _myLocationController.text = address;
      _signUpCompanyController.setCordLocation(
        long: myLocation.longitude,
        lat: myLocation.latitude,
      );
      _signUpCompanyController.companyAddress = address;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("selecte_address".tr, style: dmsbold),
      ),
      body: BodyWidget(
        isScrollable: true,
        paddingContent: EdgeInsets.symmetric(
          vertical: width / 26,
          horizontal: width / 26,
        ),
        child: Column(
          children: [
            _buildInputAddressField(),
            SizedBox(
              height: height / 42,
            ),
            Obx(
              () => !netConnController.isConnected
                  ? _buildMessageNoConnectionToGetAddress(height)
                  : SizedBox(),
            ),
            Image.asset(JobstopPngImg.locationmap),
            SizedBox(
              height: height / 21,
            ),
            SizedBox(
              width: width,
              child: Text(
                "terms_policy_title".tr,
                textAlign: TextAlign.start,
                style: dmsbold.copyWith(fontSize: height / 42),
              ),
            ),
            SizedBox(
              height: height / 64,
            ),
            Obx(
              () => CheckboxListTile(
                title: Text(
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
    );
  }

  void _onSubmitConfirm() async {
    if (_signUpCompanyController.confirmOnPolicy &&
        _signUpCompanyController.cordLocation.isRequiredCord()) {
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

  InputField _buildInputAddressField() {
    return InputField(
      controller: _myLocationController,
      hintText: "address_hint".tr,
      icon: Icon(Icons.location_city),
      suffixIcon: IconButton(
        icon: Icon(
          Icons.my_location,
          color: Jobstopcolor.primarycolor,
        ),
        onPressed: () {
          setLocation();
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

  Future<Position?> _detectedMyLocation() async {
    var result = await LocatorService.determinePosition(
      onLocationServiceDisabled: () async {
        showAlert(
          context,
          CustomAlertDialog(
            imageAsset: JobstopPngImg.locationmap,
            title: "gps_disapplied".tr,
            description: "gps_disapplied_desc".tr,
            confirmBtnTitle: "ok",
            onConfirm: () async {
              await LocatorService.openLocationSettings();
              Get.back();
            },
            cancelBtnTitle: "cancel",
            onCancel: () => Get.back(),
          ),
        );
      },
      onLocationPermissionDenied: () {
        showAlert(
          context,
          CustomAlertDialog(
            imageAsset: JobstopPngImg.locationmap,
            title: "Loc_ermission_denied".tr,
            description: "Loc_ermission_denied_desc".tr,
            confirmBtnTitle: "ok",
            onConfirm: () async {
              await LocatorService.requestPermissionAgain();
              Get.back();
            },
            cancelBtnTitle: "cancel".tr,
            onCancel: () => Get.back(),
          ),
        );
      },
    );
    print("latitude: ${result?.latitude}");
    print("longitude: ${result?.longitude}");
    return result;
  }
}
