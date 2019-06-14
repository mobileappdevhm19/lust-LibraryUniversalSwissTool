import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lust/models/library.dart';

class LocationAPI {
  static Future getLocation() async {

    Library libHM;
    final String bibLat = 'latitude';
    final String bibLon = 'longitude';
    String snapLat, snapLon;

    Position currentLocation = await Geolocator().getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    //LIB: {48.153954, 11.552292}
    //libHM = new Library(latitude: 48.153954, longitude: 11.552292);

    final DocumentReference documentHM =
        Firestore.instance.collection('libs').document('centralHM');

    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot snapshot = await tx.get(documentHM);
      if (snapshot.exists) {
        snapLat = await snapshot.data[bibLat].toString();
        snapLon = await snapshot.data[bibLon].toString();
        libHM = new Library(
            latitude: double.parse(snapLat), longitude: double.parse(snapLon));
      }
    });

    double distance = await Geolocator().distanceBetween(
        currentLocation.latitude,
        currentLocation.longitude,
        libHM.latitude,
        libHM.latitude);


   /*if (distance < 100) {
      return true;
    }
    return false;
  }*/
   return snapLat;
}}
