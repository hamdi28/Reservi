import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';

class BookingCtr extends GetxController {
  var currentstep = 0.obs;
  var selected = false.obs;
  var showtext = false.obs;
  List weekends = <DateTime>[];

  var rendivous = ''.obs;
  var rdvid = ''.obs;
  var userid = ''.obs;
  var docid = ''.obs;
  var file = ''.obs;
  var message = ''.obs;

  var select = 0.obs;

  setstep(int index) {
    currentstep.value = index;
    update();
  }

  slectddoc(int indexx) {
    select.value = indexx;
    update();
  }

  daterdv(String date) {
    rendivous.value = '';
    rendivous.value += date;
    update();
  }

  datefinal(String Heure) {
    rendivous.value = rendivous.value + '  ' + Heure;
    update();
  }

  forward() {
    if (currentstep.value < 2) {
      currentstep += 1;
      update();
    }
  }

  backword() {
    if (currentstep.value != 0) {
      currentstep -= 1;
      update();
    }
  }

  unshow() {
    selected.value = !selected.value;

    update();
  }

  uploaddoc(String filename, Uint8List filebytes) async {
    try {
      await FirebaseStorage.instance.ref('Docs/$filename').putData(filebytes);
    } catch (e) {}
  }

  getfile(String val) {
    file.value = '';
    file.value = val;
    update();
  }

  storeRdv({
    required BuildContext context,
    required String docid,
    required String daterdv,
    required String message,
    required String file,
  }) async {
    try {
      DocumentReference docref =
          FirebaseFirestore.instance.collection('Appoiament').doc();
      docref
        ..set({
          'RdvId': docref.id,
          'UserID': FirebaseAuth.instance.currentUser!.uid,
          'DocID': docid,
          'DateRdv': daterdv,
          'message': message,
          'File': file,
          'Etat': 'wating'
        }).then((value) {
          MotionToast.success(
            description: const Text('Rendez-vous Ajouter avec succes'),
            animationDuration: const Duration(milliseconds: 3000),
            onClose: () {
              Get.back();
            },
          ).show(context);
        });
    } catch (e) {}
  }
}
