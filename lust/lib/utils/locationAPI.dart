import 'package:geolocator/geolocator.dart';
import 'package:lust/models/bibs.dart';
<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationAPI {
  static Future getLocation() async {
    /*LIB: {48.153954, 11.552292}
    Library libHM = new Library(48.153954, 11.552292);
    Position positionStudent = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    List<Placemark> positionLib = await Geolocator().placemarkFromAddress("Lothstraße 13D, 80335 München");*/
    Library libHM;
    final String bibLat = "latitude";
    final String bibLon = "longitude";
    String snapLat, snapLon;

    Position currentLocation = await Geolocator().getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    final DocumentReference documentHM =
    Firestore.instance.collection('libs').document('centralHM');

    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot snapshot = await tx.get(documentHM);
      if (snapshot.exists) {
        snapLat = await snapshot.data[bibLat].toString();
        snapLon = await snapshot.data[bibLon].toString();
        libHM = new Library(double.parse(snapLat), double.parse(snapLon));
      }
    });

    double distance = await Geolocator().distanceBetween(
        currentLocation.latitude,
        currentLocation.longitude,
        libHM.latitude,
        libHM.latitude);

    if (distance < 100) {
      return true;
    }
    return false;
  }}
=======

class LocationAPI{
  static Future getLocation() async {
    //LIB: {48.153954, 11.552292}
    Library libHM = new Library(48.153954, 11.552292);
    Position positionStudent = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    List<Placemark> positionLib = await Geolocator().placemarkFromAddress("Lothstraße 13D, 80335 München");

    double distance = await Geolocator().distanceBetween(positionStudent.latitude, positionStudent.longitude, libHM.latitude, libHM.latitude);

    if (distance <100){
      return true;
    }
    else{
      return false;
    }
  }
}

>>>>>>> rebasing
