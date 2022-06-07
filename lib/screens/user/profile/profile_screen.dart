import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservi/screens/appoimets/allappoiments/allapoiments_controller.dart';
import 'package:reservi/screens/appoimets/allappoiments/listappoiment.dart';
import 'package:reservi/screens/home/homescreen.dart';
import 'package:reservi/screens/shared/animation.dart';
import 'package:reservi/screens/shared/delay.dart';
import 'package:reservi/screens/user/Edit/edit_screen.dart';
import 'package:reservi/screens/user/profile/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileCtr());
    var state = false.obs;
    Get.put(ListAppCtr());
    var allapp = Get.find<ListAppCtr>().allapp;
    var wapp = Get.find<ListAppCtr>().wapp;
    var aapp = Get.find<ListAppCtr>().aapp;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      //backgroundColor: Colors.transparent,
      appBar: AppBar(
        actions: [
          FirebaseAuth.instance.currentUser != null
              ? IconButton(
                  onPressed: () {
                    controller.logout();
                  },
                  icon: const Icon(Icons.logout))
              : const Icon(null)
        ],
        elevation: 0.0,
        title: Row(
          children: [
            const Icon(
              Icons.calendar_month_sharp,
              size: 30,
            ),
            Text(
              'Rese',
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.bodyText1,
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            AnimatedTextKit(
              pause: const Duration(seconds: 1),
              animatedTexts: [
                RotateAnimatedText('Rvi',
                    textStyle: GoogleFonts.portLligatSans(
                      fontSize: 30.0,
                      color: Colors.red,
                    )),
                RotateAnimatedText('Rvi',
                    textStyle: GoogleFonts.portLligatSans(
                      fontSize: 30.0,
                      color: Colors.yellow,
                    )),
              ],
              repeatForever: true,
              onTap: () {
                // print("Tap Event");
              },
            ),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: Container(
                    color: Colors.grey[50],
                    child: Column(children: <Widget>[
                      Stack(children: <Widget>[
                        //const LinearProgressIndicator(),
                        Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            alignment: Alignment.topCenter,
                            height: 180.0,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.elliptical(500, 500),
                              ),
                              color: Colors.blueAccent,
                            ),
                            child: CircleAvatar(
                              //height: 170,
                              maxRadius: 100,
                              /*backgroundImage: NetworkImage(
                                  "${snapshot.data!['photoUrl']}")*/
                              backgroundImage:
                                  NetworkImage("${snapshot.data!['photoUrl']}"),
                            )),
                        Container(
                          padding: const EdgeInsetsDirectional.only(top: 155),
                          alignment: Alignment.bottomCenter,
                          child: CircleAvatar(
                              child: IconButton(
                                  onPressed: () {
                                    Get.to(const EditScreen(),
                                        arguments: controller.myinfo);
                                  },
                                  icon: const Icon(Icons.edit))),
                        )
                      ]),
                      Expanded(
                        flex: 2,
                        child: Container(
                          // margin: const EdgeInsets.only(top: 20.0),
                          alignment: Alignment.topCenter,

                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.elliptical(500, 500),
                            ),
                            color: Colors.blueAccent,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: AlignmentDirectional.topCenter,
                                child: Text(
                                  "${snapshot.data!['Nom']}"
                                  " "
                                  "${snapshot.data!['prenom']}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    //color: d_red,
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  heightFactor: 1,
                                  widthFactor: 8,
                                  child: GestureDetector(
                                    onTap: () => Get.to(const Homepage()),
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
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              ListView(
                                shrinkWrap: true,
                                children: [
                                  DelayedAnimation(
                                    delay: 2000,
                                    child: Container(
                                      color: Colors.white,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: ListTile(
                                        leading: const CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            child: Icon(Icons.phone)),
                                        title: const Text('Télephone'),
                                        subtitle:
                                            Text("${snapshot.data!['phone']}"),
                                        iconColor: Colors.green,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  DelayedAnimation(
                                    delay: 2100,
                                    child: Container(
                                      color: Colors.white,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: ListTile(
                                        leading: const CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            child: Icon(Icons.email)),
                                        title: const Text('EMAIL'),
                                        subtitle:
                                            Text("${snapshot.data!['email']}"),
                                        iconColor: Colors.green,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 08,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      DelayedAnimation(
                                        delay: 2500,
                                        child: Container(
                                          height: 90,
                                          width: 90,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            color: Colors.white,
                                          ),
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Totale RDV',
                                                style: GoogleFonts.abel(
                                                    fontSize: 18.0,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                '$allapp',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 24.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      DelayedAnimation(
                                        delay: 2600,
                                        child: Container(
                                          height: 90,
                                          width: 90,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            color: Colors.white,
                                          ),
                                          alignment: Alignment.center,
                                          child: IntrinsicWidth(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'En Attente',
                                                  style: GoogleFonts.abel(
                                                      fontSize: 18.0,
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  '$wapp',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 24.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      DelayedAnimation(
                                        delay: 2700,
                                        child: Container(
                                          height: 90,
                                          width: 90,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            color: Colors.white,
                                          ),
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Annuler',
                                                style: GoogleFonts.abel(
                                                    fontSize: 18.0,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                '$aapp',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 24.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ])),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(const ListAppoiments());
        },
        icon: const Icon(Icons.arrow_right),
        label: const Text('Consulter Mes Rendez-vous'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
