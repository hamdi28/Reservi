import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:reservi/screens/home/welcomepage.dart';

class Homecontroller extends GetxController {
  logout() async {
    await FirebaseAuth.instance.signOut().then((value) {
      Get.offAll(WelcomePage());
    });
  }

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

  @override
  void onInit() async {
    await image();
    print(pic);
    // TODO: implement onInit
    super.onInit();
  }
}
