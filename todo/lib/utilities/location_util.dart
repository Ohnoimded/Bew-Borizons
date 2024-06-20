// Get location with location library
import 'package:location/location.dart';

class LocationUtil {
  static Location location = Location();

  static Future<LocationData?> getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    // Check if location services are enabled
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    // Check and request location permissions
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    // Get location data
    if (_permissionGranted == PermissionStatus.granted) {
      try {
        _locationData = await location.getLocation();
        print(_locationData);
        return _locationData;
      } catch (e) {
        print('Error getting location: $e');
        return null;
      }
    } else {
      return null;
    }
  }
}
