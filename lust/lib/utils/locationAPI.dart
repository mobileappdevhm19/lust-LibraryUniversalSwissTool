import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lust/models/library.dart';

class LocationAPI {

  static Future<bool> getLocation(GeoPoint _point) async {
    final double _maxRadius = 150;
    double _distance;
    Library libHM = new Library(longitude: _point.longitude, latitude: _point.latitude);

    Position currentLocation = await Geolocator().getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    print('USER coordinates: (${currentLocation.latitude}, ${currentLocation.longitude})');

    _distance = await Geolocator().distanceBetween(
        currentLocation.latitude,
        currentLocation.longitude,
        libHM.latitude,
        libHM.longitude);
    print('DISTANCE: $_distance');

   if (_distance < _maxRadius) {
      return true;
    }
    return false;
  }
}
