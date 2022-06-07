import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:reservi/screens/user/profile/profile_controller.dart';
import 'package:reservi/screens/user/profile/profile_screen.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';

class EditscrenCtr extends GetxController {
  List userdata = Get.arguments;
  var image = ''.obs;
  var loading = false.obs;
  onload() {
    loading.value = !loading.value;
    update();
  }

  updateinfo({
    required BuildContext context,
    required String nom,
    required String prenom,
    required String phone,
    required String email,
    required String Nvimg,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'ID': FirebaseAuth.instance.currentUser!.uid,
        'Nom': nom,
        'prenom': prenom,
        'phone': phone,
        'email': email,
        'photoUrl': Nvimg
      }).then((value) {
        MotionToast.success(
          description: const Text('information Ajouter avec succes'),
          animationDuration: const Duration(milliseconds: 3000),
          onClose: () {
            Get.offAll(const ProfileScreen());
            Get.find<ProfileCtr>().updata();
          },
        ).show(context);
      });
    } catch (e) {}
  }

  late File _imagefile;
  final picker = ImagePicker();
  Future changeprofilepic() async {
    final imagepicked = await picker.pickImage(source: ImageSource.gallery);
    _imagefile = File(imagepicked!.path);
    //String imagename=basename
    //image.value = imagepicked.path;
    update();
  }

  Future changeprofilecam() async {
    final imagepicked = await picker.pickImage(source: ImageSource.camera);
    _imagefile = File(imagepicked!.path);
    //String imagename=basename
    //image.value = imagepicked.path;
    update();
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String imagename = Path.basename(_imagefile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("Users/$imagename");
    UploadTask uploadtask = firebaseStorageRef.putFile(_imagefile);
    uploadtask.then((res) {
      res.ref.getDownloadURL().then((value) async {
        print(value);
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'photoUrl': value,
        });
        userdata[0]['photoUrl'] = value;
        update();
      });

      /*String imgurl = await FirebaseStorage.instance
        .ref()
        .child("Users/$imagename")
        .getDownloadURL();
    uploadtask.whenComplete((){});
    uploadtask.then((res) async {
      print(imgurl);
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'photoUrl': imgurl});
      image.value = imgurl;
      update();
    });*/
    });
  }

  @override
  void onInit() {
    Get.find<ProfileCtr>().updata();
    // TODO: implement onInit
    super.onInit();
  }
}
