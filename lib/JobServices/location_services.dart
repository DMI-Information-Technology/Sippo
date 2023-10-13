import 'package:geocoding/geocoding.dart' as geoCoding;
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class LocationServices {
  static Future<LocationData?> getCurrentLocation() async {
    final _location = Location();

    try {
      if (!(await locationServicesEnabled(_location))) {
        throw LocationServiceDisabledException();
      }
      if (!(await checkLocationServicesPermission(_location))) {
        throw PermissionDeniedException('');
      }
      final locationData = await _location.getLocation();
      if (locationData.longitude == null || locationData.latitude == null) {
        throw Exception("Null location data returned from location service.");
      }
      return locationData;
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }

    // return location;
  }

  static Future<bool> checkLocationServicesPermission(Location location) async {
    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  static Future<bool> locationServicesEnabled(Location location) async {
    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }
    return true;
  }

  static Future<List<geoCoding.Placemark>?> getMyAddress(
    double latitude,
    double longitude,
  ) async {
    try {
      return await geoCoding.placemarkFromCoordinates(
        latitude,
        longitude,
        localeIdentifier: "en_US",
      );
    } catch (e, s) {
      print(s);
      print(e);
      return null;
    }
  }

  static String filterAddress(List<geoCoding.Placemark> address) {
    return address
        .map((e) => e.locality)
        .toSet()
        .where((e) => e != null && e.trim().isNotEmpty)
        .toList()
        .join(", ");
  }
}
