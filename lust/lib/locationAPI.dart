import 'package:geolocator/geolocator.dart';

class LocationAPI{
  static Future getLocation() async {
    //LIB: {48.153954, 11.552292}

    Position positionStudent = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    List<Placemark> positionLib = await Geolocator().placemarkFromAddress("Lothstraße 13D, 80335 München");

    double distance = await Geolocator().distanceBetween(positionStudent.latitude, positionStudent.longitude, positionLib.latitude, positionLib.longitude)
  }
}
