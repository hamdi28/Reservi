import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:reservi/screens/Login/loginuser.dart';

import '../shared/const.dart';

class AdduserCtr extends GetxController {
  var secure = true.obs;
  final box = GetStorage();
  switching() {
    secure.value = !secure.value;
    update();
    return secure.value;
  }

  registration({
    required BuildContext context,
    required String nom,
    required String prenom,
    required String phone,
    required String email,
    required String password,
  }) async {
    Codec stringToBase64 = utf8.fuse(base64);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      try {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.uid.toString())
            .set({
          'ID': userCredential.user!.uid.toString(),
          'Nom': nom,
          'prenom': prenom,
          'phone': phone,
          'email': email,
          'password': stringToBase64.encode(password),
          'photoUrl': defulatimage
        }).then((value) {
          MotionToast.success(
            description: const Text('Compte créer avec succes'),
            animationDuration: const Duration(milliseconds: 2000),
            onClose: () {
              Get.to(LoginPage());
              box.write('email', email);
              box.write('pass', password);
            },
          ).show(context);
        });
      } catch (e) {
        MotionToast.error(
          description: const Text('Adresee Email Deja utuliser'),
          animationDuration: const Duration(milliseconds: 2000),
        ).show(context);
        print(e.toString());
      }
    } catch (e) {
      MotionToast.error(
              description: const Text('Adresee Email Deja utuliser'),
              animationDuration: const Duration(milliseconds: 2000))
          .show(context);
      print(e.toString());
    }
  }
}
