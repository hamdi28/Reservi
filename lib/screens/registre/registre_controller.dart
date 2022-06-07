import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motion_toast/motion_toast.dart';

import '../shared/const.dart';

class RegistreConttroller extends GetxController {
  var defaultselected = 'Ariana';
  var ispas = false;
  var onload = false;
  // var dafaultpath = FirebaseStorage.instance.ref().toString();
  bool startload() {
    onload = !onload;
    update();
    return onload;
  }

  String changer(value) {
    defaultselected = value;
    update();
    return defaultselected;
  }

  Future<void> signup(
      {required BuildContext context,
      required String nom,
      required String prenom,
      required String adresse,
      required String phone,
      required String email,
      required String password,
      S}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      try {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.uid.toString())
            .set({
          'Nom': nom,
          'Prenom': prenom,
          'adresse': adresse,
          'phone': phone,
          'Email': email,
          'photoUrl': defulatimage
        }).then((value) {
          userCredential.user!.sendEmailVerification();

          // userCredential.user!.updatePhotoURL(downloadturl().toString());

          MotionToast.success(
            description: const Text(
                'Votre compte est crreer aver succes un email de confirmation est envoyer'),
            animationDuration: const Duration(milliseconds: 10000),
          ).show(context);
        });
      } catch (e) {
        // print(e);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        MotionToast.warning(
          description: const Text('This is a Warning'),
          animationCurve: Curves.bounceIn,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
      } else if (e.code == 'email-already-in-use') {
        MotionToast.warning(
          description: const Text('Adresse Email existe deja'),
          animationCurve: Curves.bounceOut,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 3000),
        ).show(context);
      }
    }
  }
}
