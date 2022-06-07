import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservi/screens/registre/additionelinfo_controller.dart';
import 'package:reservi/screens/shared/delay.dart';
import 'package:reservi/screens/user/Edit/edit_controller.dart';

class EditForm extends StatelessWidget {
  const EditForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(additionlinfoCtr());
    final formkey = GlobalKey<FormState>();
    var namecontroller = TextEditingController();
    var prenomcontroller = TextEditingController();

    var phonecontroller = TextEditingController();
    var emailcontroller = TextEditingController();
    var imagecontroller = '';
    //var controller = Get.put(AdduserCtr());

    return GetBuilder<EditscrenCtr>(builder: (controller) {
      String nom = controller.userdata[0]['Nom'];
      String prenom = controller.userdata[0]['prenom'];
      String phone = controller.userdata[0]['phone'];
      String email = controller.userdata[0]['email'];
      imagecontroller = controller.userdata[0]['photoUrl'];

      return controller.loading.value == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formkey,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: DelayedAnimation(
                            delay: 1500,
                            child: SizedBox(
                              height: 170,
                              width: 170,
                              child: FutureBuilder<DocumentSnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .get(),
                                  builder: (context, snapshot) {
                                    imagecontroller =
                                        "${snapshot.data!['photoUrl']}";
                                    if (snapshot.hasData) {
                                      return CircleAvatar(
                                        //height: 170,
                                        backgroundImage: NetworkImage(
                                            "${snapshot.data!['photoUrl']}"),
                                      );
                                    }
                                    return const CircularProgressIndicator
                                        .adaptive();
                                  }),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 160),
                          child: Card(
                            elevation: 6.0,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      controller.onload();
                                      controller
                                          .changeprofilecam()
                                          .then((value) {
                                        controller
                                            .uploadImageToFirebase(context)
                                            .then((value) {
                                          controller.onload();
                                        });
                                      });
                                    },
                                    child: const CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor: Colors.blue,
                                      child: Icon(Icons.photo_camera_outlined),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller
                                          .changeprofilepic()
                                          .then((value) {
                                        controller
                                            .uploadImageToFirebase(context);
                                      });
                                    },
                                    child: const CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor: Colors.blue,
                                      child: Icon(Icons.photo_album_outlined),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    DelayedAnimation(
                      delay: 3500,
                      child: TextFormField(
                        controller: namecontroller,
                        validator: (value) {
                          if (value!.isEmpty || value.length <= 2) {
                            return 'Enter un Nom valide';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: nom,
                          //labelText: 'Nom',
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DelayedAnimation(
                      delay: 3510,
                      child: TextFormField(
                        controller: prenomcontroller,
                        validator: (value) {
                          if (value!.isEmpty || value.length <= 2) {
                            return 'Enter un Prénom valide';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: prenom,
                          // labelText: 'Prénom',
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DelayedAnimation(
                      delay: 3520,
                      child: TextFormField(
                        controller: phonecontroller,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 8) {
                            return 'Enter un Numéro valide';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: phone,
                          //labelText: 'Numéro',
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DelayedAnimation(
                      delay: 3530,
                      child: TextFormField(
                        controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'Adresse Email non valide';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: email,
                          // labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DelayedAnimation(
                          delay: 3570,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              //primary: d_red,
                            ),
                            child: Text(
                              'CONFIRM',
                              maxLines: 1,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () async {
                              await controller.updateinfo(
                                  context: context,
                                  nom: namecontroller.text.isEmpty
                                      ? controller.userdata[0]['Nom']
                                      : namecontroller.text,
                                  prenom: prenomcontroller.text.isEmpty
                                      ? controller.userdata[0]['prenom']
                                      : prenomcontroller.text,
                                  phone: phonecontroller.text.isEmpty
                                      ? controller.userdata[0]['phone']
                                      : phonecontroller.text,
                                  email: emailcontroller.text.isEmpty
                                      ? controller.userdata[0]['email']
                                      : emailcontroller.text,
                                  Nvimg: imagecontroller);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        DelayedAnimation(
                          delay: 3570,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              //primary: d_red,
                            ),
                            child: Text(
                              'Cancel',
                              maxLines: 1,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () async {
                              await controller.updateinfo(
                                  context: context,
                                  nom: controller.userdata[0]['Nom'],
                                  prenom: controller.userdata[0]['prenom'],
                                  phone: controller.userdata[0]['phone'],
                                  email: controller.userdata[0]['email'],
                                  Nvimg: controller.userdata[0]['photoUrl']);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
    });
  }
}
