import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservi/screens/appoimets/allappoiments/allapoiments_controller.dart';
import 'package:reservi/screens/home/homescreen.dart';
import 'package:reservi/screens/user/profile/profile_screen.dart';

import '../../shared/animation.dart';
import '../../shared/delay.dart';
import '../../user/profile/profile_controller.dart';

class ListAppoiments extends StatelessWidget {
  const ListAppoiments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileCtr());
    List user = Get.find<ProfileCtr>().myinfo;

    final controller = Get.put(ListAppCtr());
    return GetBuilder<ListAppCtr>(builder: (controller) {
      return controller.stram != null
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Appoiament')
                  .where('UserID',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const CircleAvatar();
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  controller.lengeur(index: documents.length);
                  print(
                    controller.alldoc.length,
                  );

                  return Scaffold(
                    backgroundColor: Colors.white,
                    body: Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: ListView(shrinkWrap: true, children: [
                          Container(
                            margin: const EdgeInsets.only(
                                bottom: 10, left: 10, right: 10),
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Gérer Vos Rendez-vous Maintenent !",
                              style: GoogleFonts.poppins(
                                //color: d_red,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(const ProfileScreen());
                                        },
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              '${user[0]['photoUrl']}'),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      FittedBox(
                                          child: Text(
                                        '${user[0]['Nom']}',
                                        maxLines: 1,
                                        style: GoogleFonts.poppins(
                                          fontSize: 20.0,
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.offAll(const Homepage());
                                  },
                                  child: const DelayedAnimation(
                                    delay: 1500,
                                    child: ImageRotate(
                                      child: CircleAvatar(
                                        //maxRadius: 50,
                                        //height: 170,
                                        backgroundImage: AssetImage(
                                            'assets/images/luncion.png'),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          documents.isNotEmpty
                              ? ListView.separated(
                                  itemCount: documents.length,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 8,
                                    );
                                  },
                                  shrinkWrap: true,
                                  itemBuilder: ((context, index) {
                                    return controller.stram != null
                                        ? Container(
                                            height: 80,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Dismissible(
                                              key: ValueKey<int>(index),
                                              child: Card(
                                                elevation: 4,
                                                color: Colors.grey[100],
                                                child: ListTile(
                                                    leading: CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          controller.docinfoimg(
                                                              iddoc: documents[
                                                                      index]
                                                                  ['DocID'],
                                                              index: index)),
                                                    ),
                                                    title: Text(
                                                        controller.docinfo(
                                                            iddoc:
                                                                documents[index]
                                                                    ['DocID'],
                                                            index: index)),
                                                    subtitle: Text(
                                                        documents[index]
                                                            ['DateRdv']),
                                                    trailing: controller.state(
                                                        context: context,
                                                        rdiid: documents[index]
                                                            ['RdvId'],
                                                        etat: documents[index]
                                                            ['Etat'])),
                                              ),
                                            ),
                                          )
                                        : const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                  }),
                                )
                              : Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 50),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      'Vous n\'avez Acun  Rendez-vous!',
                                      style: GoogleFonts.poppins(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                      maxLines: 2,
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/empty.gif'))),
                                )
                        ])),
                    bottomNavigationBar: Container(
                      margin: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            color: Colors.red,
                            height: 7,
                            width: 12,
                          ),
                          const Text(
                            'En attent',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Container(
                            color: Colors.green,
                            height: 7,
                            width: 12,
                          ),
                          const Text(
                            'Valider',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Scaffold(
                    body: Container(
                        color: Colors.white,
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child:
                            const Center(child: CircularProgressIndicator())));
              })
          : Scaffold(
              body: Container(
                color: Colors.white,
                height: double.maxFinite,
                width: double.maxFinite,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
    });
  }
}
