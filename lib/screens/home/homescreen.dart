import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservi/Faq/faq_screen.dart';
import 'package:reservi/screens/appoimets/allappoiments/listappoiment.dart';
import 'package:reservi/screens/appoimets/booking/bookingnew.dart';
import 'package:reservi/screens/home/homecontroler.dart';
import 'package:reservi/screens/home/search/search_screen.dart';
import 'package:reservi/screens/settings/settings.dart';
import 'package:reservi/screens/user/profile/profile_screen.dart';

import '../shared/animation.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Homecontroller());
    return Scaffold(
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
              pause: const Duration(milliseconds: 0),
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
      body: GetBuilder<Homecontroller>(
        builder: ((controller) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      alignment: Alignment.topCenter,
                      height: 250.0,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(30, 8),
                          bottomRight: Radius.elliptical(30, 8),
                        ),
                        color: Colors.blueAccent,
                      ),
                      child: Image.asset("assets/images/cover.jpg"),
                    ),
                    Container(
                      //color: Colors.white,
                      width: 400.0,
                      padding:
                          const EdgeInsets.only(top: 223, left: 55, right: 55),
                      child: TextField(
                        onTap: () {
                          Get.to(const Searchscreen(),
                              transition: Transition.downToUp,
                              duration: const Duration(milliseconds: 900));
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                          alignLabelWithHint: true,
                          hintText: '  Recherche',
                          hintStyle: TextStyle(
                              fontSize: 18.0, overflow: TextOverflow.ellipsis),
                          prefixIcon: ImageRotate(
                            child: CircleAvatar(
                              //maxRadius: 50,
                              //height: 170,
                              backgroundImage:
                                  AssetImage('assets/images/luncion.png'),
                            ),
                          ),
                          filled: true,
                        ),
                        //onSubmitted :
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                  child: Card(
                    elevation: 6.0,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Get.to(const ProfileScreen());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      FutureBuilder<DocumentSnapshot>(
                                          future: FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .get(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return CircleAvatar(
                                                radius: 30.0,
                                                // backgroundColor: Colors.blue,
                                                // child:
                                                //     Icon(Icons.person_outline_outlined)
                                                backgroundImage: NetworkImage(
                                                    "${snapshot.data!['photoUrl']}"),
                                              );
                                            }
                                            return const CircleAvatar(
                                              radius: 30.0,
                                              backgroundColor: Colors.blue,
                                              child: Icon(Icons
                                                  .person_outline_outlined),
                                            );
                                          }),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      const Text('Profile')
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await Get.to(const ListAppoiments());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: const <Widget>[
                                      CircleAvatar(
                                        radius: 30.0,
                                        backgroundColor: Colors.blue,
                                        child: Icon(Icons.list_alt),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text('Mes Rende-vous')
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Get.to(const FaqScreen());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: const <Widget>[
                                      CircleAvatar(
                                          radius: 30.0,
                                          backgroundColor: Colors.green,
                                          child: Icon(Icons.question_mark)),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text('FAQ')
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(const SettigScreen());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: const <Widget>[
                                      CircleAvatar(
                                        radius: 30.0,
                                        backgroundColor: Colors.blue,
                                        child: Icon(Icons.settings),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text('   Parametre      ')
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                /* Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                  child: Card(
                    elevation: 6.0,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor: Colors.green,
                                    child: Icon(Icons.question_mark)),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Demander une question',
                                style: GoogleFonts.roboto(
                                    fontSize: 19.0, color: Colors.green[300]),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'Question fréquente',
                                style: GoogleFonts.roboto(
                                    fontSize: 19.0, color: Colors.green[300]),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ))*/
              ]),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(const BookingsScreen());
        },
        icon: const Icon(Icons.add),
        label: const Text('Ajouter Rendez-vous'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
