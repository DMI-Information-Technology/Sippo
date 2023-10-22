import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/company_profile_controller/selected_company_work_place_controller.dart';
import 'package:jobspot/sippo_custom_widget/ConditionalWidget.dart';
import 'package:jobspot/sippo_custom_widget/custom_drop_down_button.dart';
import 'package:jobspot/sippo_custom_widget/google_map_view_widget.dart';
import 'package:jobspot/sippo_custom_widget/success_message_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

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
                'Add New Work Place',
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
              Obx(() => ConditionalWidget(
                    _controller.states.isSuccess,
                    data: _controller.states,
                    guaranteedBuilder: (context, data) =>
                        CardNotifyMessage.success(
                      state: data,
                      onCancelTap: () {
                        _controller.changeStates(isSuccess: false, message: '');
                      },
                    ),
                  )),
              Text(
                'City',
                style: dmsbold.copyWith(
                  fontSize: FontSize.title5(context),
                ),
                textAlign: TextAlign.start,
              ),
              Obx(() => CustomDropdownButton(
                    textHint: 'Select Company Work Place',
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
                    setInitialValue: false,
                  )),
              SizedBox(
                height: context.fromHeight(CustomStyle.spaceBetween),
              ),
              Text(
                'Location Coordinates',
                style: dmsbold.copyWith(
                  fontSize: FontSize.title5(context),
                ),
                textAlign: TextAlign.start,
              ),
              GoogleMapViewWidget(
                controller: _controller.googleMapViewController,
                onMapLocationMarked: (_) => _,
              ),
              ListTile(
                title: _locationAddressNameTextBuilder(context),
                subtitle: ListenableBuilder(
                  listenable: _controller.googleMapViewController,
                  builder: _coordinatesTextBuilder,
                ),
                trailing: _isHqCheckBoxBuilder(context),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(context.fromWidth(CustomStyle.paddingValue)),
        child: CustomButton(
          onTapped: () => _controller.onSaveWorkPlaceSubmitted(),
          text: 'Save Work Place',
        ),
      ),
    );
  }

  Widget _isHqCheckBoxBuilder(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('is HQ', style: dmsmedium),
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
              style: dmsmedium,
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
              style: dmsregular,
            )
          : const SizedBox.shrink();
    });
  }
}
