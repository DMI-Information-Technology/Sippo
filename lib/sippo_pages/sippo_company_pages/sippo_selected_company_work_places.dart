import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/company_profile_controller/selected_company_work_place_controller.dart';
import 'package:sippo/sippo_custom_widget/ConditionalWidget.dart';
import 'package:sippo/sippo_custom_widget/confirmation_bottom_sheet.dart';
import 'package:sippo/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:sippo/sippo_custom_widget/custom_drop_down_button.dart';
import 'package:sippo/sippo_custom_widget/google_map_view_widget.dart';
import 'package:sippo/sippo_custom_widget/success_message_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';

class SippoSelectCompanyWorkPlaces extends StatefulWidget {
  const SippoSelectCompanyWorkPlaces({super.key});

  @override
  State<SippoSelectCompanyWorkPlaces> createState() =>
      _SippoSelectCompanyWorkPlacesState();
}

class _SippoSelectCompanyWorkPlacesState
    extends State<SippoSelectCompanyWorkPlaces> {
  final _controller = SelectedCompanyWorkPlaceController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.paddingValue),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'add_new_work_place'.tr,
                style: dmsbold.copyWith(
                  fontSize: FontSize.title4(context),
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: context.fromHeight(CustomStyle.spaceBetween),
              ),
              Obx(() => ConditionalWidget(
                    _controller.states.isLoading,
                    guaranteedBuilder: (context, data) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
              Obx(() => ConditionalWidget(
                    _controller.states.isWarning,
                    data: _controller.states,
                    guaranteedBuilder: (context, data) =>
                        CardNotifyMessage.warning(
                      state: data,
                      onCancelTap: () {
                        _controller.changeStates(isWarning: false, message: '');
                      },
                    ),
                  )),
              Text(
                'City'.tr,
                style: dmsbold.copyWith(
                  fontSize: FontSize.title5(context),
                ),
                textAlign: TextAlign.start,
              ),
              Obx(() => CustomDropdownButton(
                    textHint: 'select_company_work_place'.tr,
                    labelList: _controller
                        .selectedWorkPlaceState.locationsAddressNameList,
                    values:
                        _controller.selectedWorkPlaceState.locationsAddressList,
                    fillColor: Colors.white,
                    onItemSelected: (value) async {
                      if (value == null) return;
                      _controller.selectedWorkPlaceState
                          .selectedLocationAddress = value;
                      print(value);
                    },
                    setInitialValue: _controller.selectedWorkPlaceState
                            .selectedLocationAddress.id !=
                        null,
                    initialValue: _controller
                        .selectedWorkPlaceState.selectedLocationAddress.name,
                  )),
              SizedBox(
                height: context.fromHeight(CustomStyle.spaceBetween),
              ),
              Text(
                'location_coordinates'.tr,
                style: dmsbold.copyWith(
                  fontSize: FontSize.title5(context),
                ),
                textAlign: TextAlign.start,
              ),
              GoogleMapViewWidget(
                controller: _controller.googleMapViewController,
                onMapLocationMarked: (_) => _,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: context.fromHeight(CustomStyle.spaceBetween),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _locationAddressNameTextBuilder(context),
                    ListenableBuilder(
                      listenable: _controller.googleMapViewController,
                      builder: _coordinatesTextBuilder,
                    ),
                    _isHqCheckBoxBuilder(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildSubmitButtons(context),
    );
  }

  Padding _buildSubmitButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.fromWidth(CustomStyle.paddingValue)),
      child: Row(
        children: [
          if (_controller.isEditing) ...[
            Expanded(
              child: CustomButton(
                onTapped: _showRemove,
                text: 'remove'.tr,
                textColor: SippoColor.primarycolor,
                backgroundColor: SippoColor.lightprimary,
              ),
            ),
            SizedBox(width: context.fromWidth(CustomStyle.spaceBetween)),
          ],
          Expanded(
            child: CustomButton(
              onTapped: () => _controller.onSaveWorkPlaceSubmitted(),
              text: 'save'.tr,
            ),
          ),
        ],
      ),
    );
  }

  void _showRemove() {
    Get.bottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      ContainerBottomSheetWidget(
        notchColor: SippoColor.primarycolor,
        children: [
          ConfirmationBottomSheet(
            title: "title_remove_work_place".tr,
            description: "ask_dialog_confirm_entered_change".tr,
            onConfirm: () async {
              Get.back();
              _controller.onDeleteSubmitted().then((value) {
                if (_controller.states.isSuccess) {
                  if (Get.isOverlaysOpen) Get.back();
                  Get.back();
                }
              });
            },
            onUndo: () {
              if (Get.isOverlaysOpen) Get.back();
            },
          )
        ],
      ),
    );
  }

  Widget _isHqCheckBoxBuilder(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${'is_hq_label'.tr}",
          style: dmsmedium,
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        Obx(() => Checkbox(
              value: _controller.selectedWorkPlaceState.isHq,
              onChanged: (value) =>
                  _controller.selectedWorkPlaceState.isHq = value ?? false,
            )),
      ],
    );
  }

  Widget _locationAddressNameTextBuilder(context) {
    return Obx(() {
      final addressName =
          _controller.selectedWorkPlaceState.selectedLocationAddress.name ?? '';
      return addressName.isNotEmpty
          ? Text(
              addressName,
              style: dmsmedium.copyWith(fontSize: FontSize.title4(context)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          : const SizedBox.shrink();
    });
  }

  Widget _coordinatesTextBuilder(context, widget) {
    return Obx(() {
      final addressName =
          _controller.selectedWorkPlaceState.selectedLocationAddress.name ?? '';
      final markerPlace = _controller.googleMapViewController.markerPlace;
      return addressName.isNotEmpty
          ? Text(
              "${markerPlace.position.latitude.toStringAsFixed(7)},"
              " ${markerPlace.position.longitude.toStringAsFixed(7)}",
              style:
                  dmsregular.copyWith(fontSize: FontSize.paragraph2(context)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          : const SizedBox.shrink();
    });
  }
}
