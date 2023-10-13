import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';

import '../JobGlobalclass/sippo_customstyle.dart';
import '../custom_app_controller/google_map_view_controller.dart';

class GoogleMapViewWidget extends StatelessWidget {
  const GoogleMapViewWidget(
      {super.key, required this.controller, required this.onMapLocationMarked});

  final GoogleMapViewController controller;
  final void Function(LatLng latLng) onMapLocationMarked;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.fromWidth(1),
      height: context.fromHeight(2.7),
      child: RoundedBorderRadiusCardWidget(
        padding: EdgeInsets.all(
          context.fromWidth(CustomStyle.paddingValue),
        ),
        child: Stack(
          children: [
            ListenableBuilder(
                listenable: controller,
                builder: (context, widget) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: GoogleMap(
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      onMapCreated: (value) => controller.mapController = value,
                      initialCameraPosition: controller.initialCameraPosition,
                      markers: {controller.markerPlace},
                      onLongPress: (latLng) async {
                        await controller.onMapLocationMarked(latLng);
                        onMapLocationMarked(latLng);
                      },
                    ),
                  );
                }),
            _buildGetCurrentLocationButton(context)
          ],
        ),
      ),
    );
  }

  Align _buildGetCurrentLocationButton(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: ElevatedButton(
        onPressed: () {
          controller.getCurrentLocation();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.8),
          padding: EdgeInsets.zero,
          shape: CircleBorder(),
        ),
        child: ListenableBuilder(
            listenable: controller,
            builder: (context, widget) {
              return Icon(
                Icons.my_location,
                color: controller.isCurrentLocationTapped
                    ? Colors.blueAccent
                    : Colors.black54,
              );
            }),
      ),
    );
  }
}
