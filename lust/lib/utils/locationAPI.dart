import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lust/models/library.dart';
import 'package:lust/models/location.dart';

class LocationAPI {

  static Future<Location> getLocation(GeoPoint _point) async {

    final double _maxRadius = 300;
    double _distance;
    bool _onRange;
    print("step 1 xxxx");
    Library libHM = new Library.withLocation(_point);
    print("step 2 xxxx");

    Position currentLocation = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    print(
        'USER coordinates: (${currentLocation.latitude}, ${currentLocation.longitude})');

    _distance = await Geolocator().distanceBetween(currentLocation.latitude,
        currentLocation.longitude, libHM.location.latitude, libHM.location.longitude);

    if (_distance < _maxRadius) {
      _onRange = true;
    } else {
      _onRange = false;
    }

    return new Location(distance: _distance, onRange: _onRange);
  }
}
