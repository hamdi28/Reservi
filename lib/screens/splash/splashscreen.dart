import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:reservi/screens/home/homescreen.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(child: Lottie.asset('assets/images/loaader.json')),
      backgroundColor: HexColor('#0b1f52'),
      //duration: 400,
      nextScreen: const Homepage(),
      splashIconSize: 100,
      disableNavigation: true,
    );
  }
}
