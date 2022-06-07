import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:reservi/screens/home/homescreen.dart';

class LogController extends GetxController {
  var secure = true.obs;
  //var info = Get.parameters;
  final box = GetStorage();

  signin({
    required BuildContext context,
    required String email,
    required String pass,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((value) {
        MotionToast.info(
          description: const Text('Loading'),
          animationDuration: const Duration(milliseconds: 2000),
          onClose: () {
            box.write('email', email);
            box.write('pass', pass);
            Get.offAll(const Homepage());
          },
        ).show(context);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        MotionToast.error(
          description: const Text('Utulisateur n\'existe pas'),
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
      } else if (e.code == 'wrong-password') {
        MotionToast.error(
          description: const Text('Verifier Votre Mot de passe'),
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
      }
    }
  }

  switching() {
    secure.value = !secure.value;
    update();
    return secure.value;
  }
}
