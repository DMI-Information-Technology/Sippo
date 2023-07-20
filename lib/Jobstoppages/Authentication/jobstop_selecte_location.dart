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
import '../../JopController/AuthenticationController/jobstop_signup_company_controller.dart';
import '../../utils/helper.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({super.key});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  TextEditingController _myLocationController = TextEditingController();

  @override
  void initState() {
    setLocation();
    super.initState();
  }

  Future<void> setLocation() async {
    Position myLocatio = await _detectedMyLocation();
    List<Placemark> myAddress =
        await _getMyAddress(myLocatio.latitude, myLocatio.longitude);
    String address = await _filterMyAddress(myAddress);
    _myLocationController.text = address;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width / 26,
            vertical: height / 26,
          ),
          child: Column(
            children: [
              InputField(
                controller: _myLocationController,
                hintText: "Address",
                icon: const Icon(Icons.location_city),
              ),
              SizedBox(
                height: height / 21,
              ),
              Image.asset(JobstopPngImg.locationmap),
              SizedBox(
                height: height / 21,
              ),
              SizedBox(
                width: width,
                child: Text(
                  "The terms and policy",
                  textAlign: TextAlign.start,
                  style: dmsbold.copyWith(fontSize: height / 42),
                ),
              ),
              SizedBox(
                height: height / 64,
              ),
              Obx(() => CheckboxListTile(
                    title: Text(
                      "I agree to all the terms and conditions requested by Farasah Company.",
                      style: dmsregular.copyWith(fontSize: height / 52),
                    ),
                    value: signUpCompanyController.confirmOnPolicy,
                    onChanged: (value) {
                      signUpCompanyController.toggleConfirmPolicy();
                    },
                    activeColor: Jobstopcolor.primarycolor,
                  )),
              SizedBox(
                height: height / 5,
              ),
              CustomButton(
                onTappeed: () async {
                  Get.toNamed(JopRoutesPages.identityverification);
                },
                text: "confirm".tr,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Position> _detectedMyLocation() async {
    var result = await determinePosition(
      onLocationServiceDisabled: () async {
        showAlert(
          context,
          CustomAlertDialog(
            imageAsset: JobstopPngImg.locationmap,
            title: "gps_disapplied".tr,
            description: "gps_disapplied_desc".tr,
            confirmBtnTitle: "ok",
            onConfirm: () async {
              await Geolocator.openLocationSettings();
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
              await Geolocator.requestPermission();
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
