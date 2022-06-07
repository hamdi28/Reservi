import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:reservi/screens/home/homescreen.dart';
import 'package:reservi/screens/registre/additionelinfo.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class SocialCtr extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookLogin _facebookLogin = FacebookLogin();
  googlesginin({
    required BuildContext context,
  }) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        try {
          FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((docsnapshot) async {
            docsnapshot.exists
                ? Get.offAll(const Homepage())
                : await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(googleUser!.id.toString())
                    .set({
                    'ID': googleUser.id.toString(),
                    'email': googleUser.email,
                  }).then((value) {
                    MotionToast.success(
                      description: const Text('compte créer avec succes'),
                      animationDuration: const Duration(milliseconds: 3000),
                      onClose: () {
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .get()
                            .then((docsnapshot) {
                          docsnapshot.exists
                              ? Get.offAll(const Homepage())
                              : Get.offAll(const Additionlinfo());
                        });
                      },
                    ).show(context);
                  });
          });
        } catch (e) {
          MotionToast.error(
            description: const Text('Adresee Email Deja utuliser'),
            animationDuration: const Duration(milliseconds: 2000),
          ).show(context);
          print(e.toString());
        }
      });
    } catch (e) {}
  }

  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();

  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //   //FacebookAuthProvider.credential(loginResult.accessToken.graphDomain.)

  //   // Once signed in, return the UserCredential

  //   return FirebaseAuth.instance
  //       .signInWithCredential(facebookAuthCredential)
  //       .then((value) {
  //     print(FirebaseAuth.instance.currentUser!.email);
  //     return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  //   });
  // }
  void facebookloginMethode({
    required BuildContext context,
  }) async {
    FacebookLoginResult facebookUser =
        await _facebookLogin.logIn(permissions: [FacebookPermission.email]);
    print(facebookUser);
    final accesToken = facebookUser.accessToken!.token;

    if (facebookUser.status == FacebookLoginStatus.success) {
      final facecredentiel = FacebookAuthProvider.credential(accesToken);
      //FacebookAuthProvider.
      await _auth.signInWithCredential(facecredentiel).then((value) async {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((docsnapshot) async {
          docsnapshot.exists
              ? Get.offAll(const Homepage())
              : await FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .set({
                  'ID': FirebaseAuth.instance.currentUser!.uid,
                  'email': FirebaseAuth.instance.currentUser!.email,
                }).then((value) {
                  MotionToast.success(
                    description: const Text('compte créer avec succes'),
                    animationDuration: const Duration(milliseconds: 3000),
                    onClose: () {
                      FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get()
                          .then((docsnapshot) {
                        docsnapshot.data()!.length >= 4
                            ? Get.offAll(const Homepage())
                            : Get.offAll(const Additionlinfo());
                      });
                    },
                  ).show(context);
                });
        });
      });
    }
    /*facebookloginMethode() async {
    FacebookLoginResult facebookUser =
        await _facebookLogin.logIn(permissions: [FacebookPermission.email]);
    print(facebookUser);
    final accesToken = facebookUser.accessToken!.token;

    if (facebookUser.status == FacebookLoginStatus.success) {
      final facecredentiel = FacebookAuthProvider.credential(accesToken);
      await _auth.signInWithCredential(facecredentiel).then((value) async {
        await FirebaseFirestore.instance.collection('Users').doc().set({
          //
          
        })
      });
    }
  }*/
  }
}
