import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservi/Faq/fac_controller.dart';

import '../screens/home/homescreen.dart';
import '../screens/shared/animation.dart';
import '../screens/shared/delay.dart';
import '../screens/user/profile/profile_controller.dart';
import '../screens/user/profile/profile_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileCtr());
    List user = Get.find<ProfileCtr>().myinfo;
    var qcontroller = TextEditingController();
    final controller = Get.put(FaqCtr());

    return GetBuilder<FaqCtr>(builder: (controller) {
      return controller.stram != null
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Faq').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const CircleAvatar();
                }
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;

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
                              "Vous trouvez liste des questions les plus posser !",
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
                                  physics: const ScrollPhysics(),
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 2,
                                    );
                                  },
                                  shrinkWrap: true,
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Card(
                                        color: Colors.white,
                                        child: ListTile(
                                          leading: CircleAvatar(
                                              radius: 20.0,
                                              backgroundColor: documents[index]
                                                          ['A'] ==
                                                      'Aucune Reponse pour le moment'
                                                  ? Colors.blue
                                                  : Colors.green,
                                              child: const Icon(
                                                  Icons.question_mark)),
                                          title: Text(documents[index]['Q']),
                                          subtitle: Text(documents[index]['A']),
                                        ),
                                      ),
                                    );
                                  }),
                                  itemCount: documents.length,
                                )
                              : Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 50),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      'Acun question \'encore posser',
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
                                ),
                          const SizedBox(
                            height: 30,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              style: ButtonStyle(backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                return const Color.fromARGB(255, 186, 175, 175);
                                // Use the component's default.
                              })),
                              onPressed: () {
                                Get.defaultDialog(
                                    title: 'Passer Votre question',
                                    content: Container(
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: qcontroller,
                                          ),
                                          TextButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('Faq')
                                                    .doc()
                                                    .set({
                                                  'Q': qcontroller.text,
                                                  'A':
                                                      'Aucune Reponse pour le moment',
                                                }).then((value) {
                                                  qcontroller.clear();
                                                  AwesomeDialog(
                                                    context: context,
                                                    //body: const Text('Rendez-vous supprimer avec suucces'),
                                                    showCloseIcon: true,
                                                    title:
                                                        'Question Ajouter avec suucces',
                                                  ).show();
                                                });
                                              },
                                              child: const Text('Envoyer'))
                                        ],
                                      ),
                                    ));
                              },
                              child: const Text('Posser un Question'),
                            ),
                          )
                        ])),
                  );
                }

                return const Center(child: CircularProgressIndicator());
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
