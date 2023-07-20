import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JopCustomWidget/widgets.dart';
import 'package:get/get.dart';
import '../../JobGlobalclass/jobstopimges.dart';
import '../../JobGlobalclass/routes.dart';
import '../../JobServices/locator_service.dart';
import '../../JopController/AuthenticationController/jobstop_signup_company_controller.dart';
import '../../JopController/ConnectivityController/internet_connection_controller.dart';
import '../../utils/helper.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({super.key});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  TextEditingController _myLocationController = TextEditingController();
  final InternetConnectionController netConnController = Get.find();

  @override
  void initState() {
    super.initState();
    setLocation();
  }

  Future<void> setLocation() async {
    if (netConnController.isConnected.isTrue) {
      Position myLocatio = await _detectedMyLocation();
      List<Placemark> myAddress =
          await _getMyAddress(myLocatio.latitude, myLocatio.longitude);
      String address = await _filterMyAddress(myAddress);
      _myLocationController.text = address;
    }
  }

  @override
  Widget build(BuildContext context) {
    SignUpCompanyController signUpCompanyController = Get.find();
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("selecte_address".tr, style: dmsbold),
      ),
      body: LayoutBuilder(
        builder: (box, onstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: onstraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(
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
                        () => !netConnController.isConnected.isTrue
                            ? _buildNoConnectionToGetAddressMessage(height)
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
                          value: signUpCompanyController.confirmOnPolicy,
                          onChanged: (value) {
                            signUpCompanyController.toggleConfirmPolicy();
                          },
                          activeColor: Jobstopcolor.primarycolor,
                        ),
                      ),
                      Spacer(),
                      CustomButton(
                        onTappeed: () async {
                          if (signUpCompanyController.confirmOnPolicy) {
                            Get.toNamed(JopRoutesPages.identityverification);
                          } else {
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
                        },
                        text: "confirm".tr,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
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

  Column _buildNoConnectionToGetAddressMessage(double height) {
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

  Future<Position> _detectedMyLocation() async {
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
            onCancel: () {
              Get.back();
            },
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
            onCancel: () {
              Get.back();
            },
          ),
        );
      },
    );
    print("latitude: ${result.latitude}");
    print("longitude: ${result.longitude}");
    return result;
  }

  Future<String> _filterMyAddress(List<Placemark> myAddress) async {
    return myAddress
        .map((element) => element.locality)
        .toList()
        .where((element) => element != null && element.isNotEmpty)
        .toSet()
        .toList()
        .join(", ");
  }

  Future<List<Placemark>> _getMyAddress(
      double latitude, double longitude) async {
    return await placemarkFromCoordinates(
      latitude,
      longitude,
      localeIdentifier: "en_US",
    );
  }
}
