import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:reservi/screens/home/homescreen.dart';

import '../shared/const.dart';

class additionlinfoCtr extends GetxController {
  registration({
    required BuildContext context,
    required String nom,
    required String prenom,
    required String phone,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'ID': FirebaseAuth.instance.currentUser!.uid,
        'email': FirebaseAuth.instance.currentUser!.email,
        'Nom': nom,
        'prenom': prenom,
        'phone': phone,
        'photoUrl': defulatimage
      }).then((value) {
        MotionToast.success(
          description: const Text('information Ajouter avec succes'),
          animationDuration: const Duration(milliseconds: 3000),
          onClose: () {
            Get.offAll(const Homepage());
          },
        ).show(context);
      });
    } catch (e) {}
  }
}
