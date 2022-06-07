import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reservi/screens/home/homescreen.dart';
import 'package:reservi/screens/home/welcomepage.dart';

bool islogin = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    islogin = true;
  }
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          floatingActionButtonTheme:
              const FloatingActionButtonThemeData(backgroundColor: Colors.green)

          //primarySwatch: Colors.blue,
          ),
      home: islogin ? const Homepage() : WelcomePage(),
    );
  }
}
