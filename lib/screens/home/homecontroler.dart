import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:reservi/screens/home/welcomepage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Homecontroller extends GetxController {
  logout() async {
    await FirebaseAuth.instance.signOut().then((value) {
      Get.offAll(WelcomePage());
    });
  }

  var currentlocation;
  var latitude;
  var longitude;
  var address = 'Getting Address..'.obs;
  late StreamSubscription<Position> streamSubscription;
  Set<Marker> marker = {};
  late Marker test;

  List myinfo = [];
  var pic = '';
  image() async {
    DocumentReference userref = FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    var responsebody = await userref.get();
    myinfo.add(responsebody.data());
    update();
    pic = myinfo[0]['photoUrl'];
    update();
  }

  Future getLocation() async {
    print('init test');
    bool serviceEnabled;

    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      latitude = position.latitude;
      longitude = position.longitude;

      update();
      //getAddressFromLatLang(position);
      print(latitude.toDouble());
      update();
      marker.clear();
      marker.add(Marker(
          markerId: const MarkerId('my position'),
          position: LatLng(latitude, longitude),
          infoWindow: const InfoWindow(title: 'Votre position')));

      print(latitude);
    });
  }

  @override
  void onInit() async {
    await image();
    print(pic);
    // TODO: implement onInit
    super.onInit();
    await getLocation();
  }
}
