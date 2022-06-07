import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../home/welcomepage.dart';

class ProfileCtr extends GetxController {
  var currentuser = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  List myinfo = [];
  userinfo() {
    currentuser.forEach((element) {
      myinfo.add(element.data());
    });
  }

  var loading = true.obs;
  logout() async {
    await FirebaseAuth.instance.signOut().then((value) {
      Get.offAll(WelcomePage());
    });
  }

  updata() async {
    DocumentReference userref = FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    var responsebody = await userref.get();
    myinfo.add(responsebody.data());
    connectiondone();
    update();
  }

  connectiondone() {
    myinfo.isNotEmpty ? loading.value = !loading.value : connectiondone();
    updata();
  }

  /* loaduserinfo() async {
    try {
   var   usersnapshots = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentuser!.uid).get().asStream();
          
          if(usersnapshots.){

          }
    } catch (e) {}
  }*/
  @override
  void onInit() async {
    myinfo.clear();
    await updata();
    //connectiondone();
    update();

    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    print(myinfo.length);
    // TODO: implement onClose
    super.onClose();
  }

  upprec() {
    if (myinfo.isNotEmpty) {
      loading.value = !loading.value;
      updata();
    } else {
      updata();
      upprec();
    }
  }

  Widget wating() {
    return LinearProgressIndicator(
      backgroundColor: Colors.grey,
      color: HexColor("#0b1f52"),
    );
  }
}
