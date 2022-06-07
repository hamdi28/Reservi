import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FaqCtr extends GetxController {
  var stram;
  load() async {
    stram = FirebaseFirestore.instance
        .collection('Faq')
        .where('UserID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    update();
  }

  @override
  void onInit() async {
    await load();
    // TODO: implement onInit
    super.onInit();
  }
}
