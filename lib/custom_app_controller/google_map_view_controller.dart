import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobspot/JobServices/location_services.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/cord_location.dart';
import 'package:jobspot/utils/states.dart';

class GoogleMapViewController extends ChangeNotifier {
  static const SELECTED_MARKER = "selected_marker";

  GoogleMapViewController() {
    markers.add(_markerPlace);
  }

  GoogleMapController? _mapController;

  static const _pTripoliLibya = const LatLng(
    32.8872,
    13.1913,
  );
  final initialCameraPosition = CameraPosition(
    target: _pTripoliLibya,
    zoom: 15,
  );

  var _markerPlace = Marker(
    markerId: MarkerId(SELECTED_MARKER),
    icon: BitmapDescriptor.defaultMarker,
  );
  var _isCurrentLocationTapped = false;

  var _states = States();
  final markers = <Marker>{};

  GoogleMapController? get mapController => _mapController;

  void set mapController(GoogleMapController? value) {
    _mapController = value;
    // notifyListeners();
  }

  Marker get markerPlace => _markerPlace;

  void set markerPlace(Marker value) {
    _markerPlace = value;
    notifyListeners();
  }

  CoordLocation get markerAsCoordLocation => CoordLocation.fromDouble(
        latitude: markerPlace.position.latitude,
        longitude: markerPlace.position.longitude,
      );

  bool get isCurrentLocationTapped => _isCurrentLocationTapped;

  void set isCurrentLocationTapped(bool value) {
    _isCurrentLocationTapped = value;
    notifyListeners();
  }

  States get states => _states;

  void set states(States value) {
    _states = value;
    notifyListeners();
  }

  Future<void> onMapLocationMarked(
    LatLng? value, [
    BitmapDescriptor? bd,
  ]) async {
    if (value == null) return;
    markerPlace = markerPlace.copyWith(
      positionParam: value,
      iconParam: bd ?? BitmapDescriptor.defaultMarker,
    );
    isCurrentLocationTapped = false;
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: value, zoom: 15),
      ),
    );
  }

  void getCurrentLocation() async {
    states = states.copyWith(isLoading: true);
    final locationData = await LocationServices.getCurrentLocation();
    states = states.copyWith(isLoading: false);
    if (locationData == null) {
      states = states.copyWith(
        isError: true,
        message: 'An error occurred while trying to get the current location.',
      );
      return;
    }
    states = states.copyWith(isError: false, message: '');
    if (locationData.latitude != null && locationData.longitude != null) {
      onMapLocationMarked(
        CoordLocation.fromDouble(
          latitude: locationData.latitude,
          longitude: locationData.longitude,
        ).toLatLng,
      );
      isCurrentLocationTapped = true;
    }
  }

  @override
  void dispose() {
    print("disposing google map view controller...");
    _mapController?.dispose();
    super.dispose();
  }
}
// class OpenGoogleMapViewController extends GetxController {
//   static const SELECTED_MARKER = "selected_marker";
//   final _isCurrentLocationTapped = false.obs;
//
//   bool get isCurrentLocationTapped => _isCurrentLocationTapped.isTrue;
//
//   void set isCurrentLocationTapped(bool value) {
//     _isCurrentLocationTapped.value = value;
//   }
//
//   final _states = States().obs;
//
//   States get states => _states.value;
//
//   void set states(States value) => _states.value = value;
//
//   GoogleMapController? _mapController;
//   final searchController = GetXTextEditingController();
//   static const _pTripoliLibya = const LatLng(
//     32.8872,
//     13.1913,
//   );
//   final initialCameraPosition = CameraPosition(
//     target: _pTripoliLibya,
//     zoom: 14.4746,
//   );
//
//   GoogleMapController? get mapController => _mapController;
//
//   void setMapController(GoogleMapController value) async {
//     _mapController = value;
//   }
//
//   final _markerPlace = Marker(
//     markerId: MarkerId(SELECTED_MARKER),
//     icon: BitmapDescriptor.defaultMarker,
//   ).obs;
//
//   Marker get markerPlace => _markerPlace.value;
//
//   void set markerPlace(Marker value) {
//     _markerPlace.value = value;
//   }
//
//   Future<void> onMapLocationMarked(
//     LatLng? value, [
//     BitmapDescriptor? bd,
//   ]) async {
//     if (value == null) return;
//     markerPlace = markerPlace.copyWith(
//       positionParam: value,
//       iconParam: bd ?? BitmapDescriptor.defaultMarker,
//     );
//     isCurrentLocationTapped = false;
//     (await mapController)?.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(target: value, zoom: 14),
//       ),
//     );
//   }
//
//   void getCurrentLocation() async {
//     states = states.copyWith(isLoading: true);
//     final locationData = await LocationServices.getCurrentLocation();
//     states = states.copyWith(isLoading: false);
//     if (locationData == null) {
//       states = states.copyWith(
//         isError: true,
//         message: 'An error occurred while trying to get the current location.',
//       );
//       return;
//     }
//     states = states.copyWith(isError: false, message: '');
//     if (locationData.latitude != null && locationData.longitude != null) {
//       onMapLocationMarked(
//         CordLocation.fromDouble(
//           latitude: locationData.latitude,
//           longitude: locationData.longitude,
//         ).toLatLng,
//       );
//       isCurrentLocationTapped = true;
//     }
//   }
//
// // void onSearchTextChanged(String query) async {}
//   @override
//   void onInit() {
//     super.onInit();
//     getCurrentLocation();
//   }
//
//   @override
//   void onClose() {
//     _mapController?.dispose();
//     super.onClose();
//   }
// }
