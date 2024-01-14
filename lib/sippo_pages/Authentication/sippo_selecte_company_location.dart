import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/JobServices/app_local_language_services/app_local_language_service.dart';
import 'package:sippo/custom_app_controller/google_map_view_controller.dart';
import 'package:sippo/sippo_controller/AuthenticationController/sippo_signup_company_controller.dart';
import 'package:sippo/sippo_custom_widget/ConditionalWidget.dart';
import 'package:sippo/sippo_custom_widget/body_widget.dart';
import 'package:sippo/sippo_custom_widget/custom_drop_down_button.dart';
import 'package:sippo/sippo_custom_widget/google_map_view_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_data/model/locations_model/location_address_model.dart';

class SippoLocationCompanySelector extends StatefulWidget {
  const SippoLocationCompanySelector({super.key});

  @override
  State<SippoLocationCompanySelector> createState() =>
      _SippoLocationCompanySelectorState();
}

class _SippoLocationCompanySelectorState
    extends State<SippoLocationCompanySelector> {
  final _textLocationController = TextEditingController();
  final netConnController = InternetConnectionService.instance;
  final _signUpCompanyController = SignUpCompanyController.instance;
  final googleMapViewController = GoogleMapViewController();

  @override
  void initState() {
    super.initState();
    googleMapViewController.getCurrentLocation();
    _signUpCompanyController.fetchLocationsAddress();
  }

  @override
  void dispose() {
    _textLocationController.dispose();
    googleMapViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return PopScope(
      onPopInvoked: (pop) async {
        _signUpCompanyController.companyAddress = LocationAddress();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () {
              _signUpCompanyController.companyAddress = LocationAddress();
              Get.back();
            },
            icon: Icon(Icons.arrow_back_rounded),
          ),
          title: Text("selecte_address".tr, style: dmsbold),
          actions: [
            TextButton(
              onPressed: () {
                LocalLanguageService.showChangeLanguageBottomSheet(context);
              },
              child: Text("language".tr),
            ),
          ],
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
                "City".tr,
                style: dmsbold.copyWith(fontSize: FontSize.title5(context)),
              ),
              InkWell(
                onTap: loadLocationAddressOnTap,
                child: Obx(() => CustomDropdownButton(
                      textHint: 'select_company_work_place'.tr,
                      labelList:
                          _signUpCompanyController.locationsAddressNameList,
                      values: _signUpCompanyController.locationsAddressList,
                      fillColor: Colors.white,
                      onItemSelected: (value) async {
                        if (value == null || value.id == null) return;
                        _textLocationController.text = value.name ?? "";
                        _signUpCompanyController.companyAddress = value;
                        print(value);
                      },
                      setInitialValue: false,
                    )),
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
              Obx(
                () => ConditionalWidget(
                  _signUpCompanyController.companyAddress.name?.isNotEmpty ==
                      true,
                  guaranteedBuilder: (context, _) => ListTile(
                    title: _locationAddressNameTextBuilder(context),
                    subtitle: ListenableBuilder(
                      listenable: googleMapViewController,
                      builder: _coordinatesTextBuilder,
                    ),
                  ),
                ),
              ),
            ],
          ),
          paddingBottom: EdgeInsets.all(
            context.fromWidth(CustomStyle.paddingValue),
          ),
          bottomScreen: CustomButton(
            onTapped: _onSubmitConfirm,
            text: "Confirm".tr,
          ),
        ),
      ),
    );
  }

  Widget _locationAddressNameTextBuilder(context) {
    final addressName = _signUpCompanyController.companyAddress.name ?? '';
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
    // if (!_signUpCompanyController.confirmOnPolicy) {
    //   _showBadConfirmDialog();
    //   return;
    // }

    _signUpCompanyController.cordLocation =
        googleMapViewController.markerAsCoordLocation;
    if (_signUpCompanyController.companyAddress.id != null &&
        _signUpCompanyController.cordLocation.validateCords()) {
      await _signUpCompanyController.authController.companyRegister(
        _signUpCompanyController.companyForm,
      );
      if (_signUpCompanyController.authController.states.isSuccess) {
        _signUpCompanyController.authController.resetStates();
        _showSuccessSignupAlert();
      }
      if (_signUpCompanyController.authController.states.isError) {
        _showRegisterErrorAlert(
          _signUpCompanyController.authController.states.message,
        );
        _signUpCompanyController.authController.resetStates();
      }
    }
  }

  void _showSuccessSignupAlert() {
    Get.dialog(
      CustomAlertDialog(
        imageAsset: JobstopPngImg.successful1,
        isLottie: true,
        title: "Success".tr,
        description: "message_success_account_created".tr,
        confirmBtnColor: SippoColor.primarycolor,
        confirmBtnTitle: "ok".tr,
        onConfirm: () => Get.offAllNamed(SippoRoutes.sippoCompanyLogin),
      ),
    ).then((value) => Get.offAllNamed(SippoRoutes.sippoCompanyLogin));
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
            color: SippoColor.red,
          ),
        ),
        SizedBox(
          height: height / 21,
        ),
      ],
    );
  }

  void loadLocationAddressOnTap() {
    print('_SippoLocationCompanySelectorState.loadLocationAddressOnTap');
    if (_signUpCompanyController.locationState.value.isError) {
      print('hello world');
      if (InternetConnectionService.instance.isConnectionLostWithDialog())
        return;
      _signUpCompanyController.fetchLocationsAddress();
    }
    // else if (!_signUpCompanyController.locationState.value.isLoading &&
    //     _signUpCompanyController.locationsAddressList.isEmpty) {
    //   print('hello world 2');
    //
    //   if (InternetConnectionService.instance.isConnectionLostWithDialog())
    //     return;
    //   _signUpCompanyController.fetchLocationsAddress();
    // }
  }

  void _showRegisterErrorAlert(String? message) {
    Get.dialog(
      CustomAlertDialog(
        imageAsset: JobstopPngImg.error,
        title: "error".tr,
        description: message ?? '',
        confirmBtnColor: SippoColor.primarycolor,
        confirmBtnTitle: "ok".tr,
        onConfirm: () {
          if (Get.isOverlaysOpen) Get.back();
        },
      ),
    );
  }
}
