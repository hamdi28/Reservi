import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
//import 'package:lottie/lottie.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DrController extends GetxController {
  bool showmororless = true;
  var less = true.obs;
  onswitchshow() {
    showmororless = !showmororless;
    less.value = !less.value;
    update();
    return less.value;
  }

  String name = Get.arguments;
  var docnfo = List.empty(growable: true).obs;
  getdoctroe() async {
    DocumentReference doc =
        FirebaseFirestore.instance.collection('Doctors').doc(name);
    var response = await doc.get();
    docnfo.add(response.data());
    update();
  }

  callnumber({required String numero}) async {
    await FlutterPhoneDirectCaller.callNumber(numero);
  }

  var currentlocation;
  var latitude;
  var longitude;
  var address = 'Getting Address..'.obs;
  late StreamSubscription<Position> streamSubscription;
  Set<Marker> marker = {};
  late Marker test;
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
    await getLocation();
    await getdoctroe();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() async {
    await getLocation();
    // TODO: implement onReady
    super.onReady();
  }
}
