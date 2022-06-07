import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservi/screens/home/socialpage.dart';
import 'package:reservi/screens/registre/Adduser.dart';

import '../shared/delay.dart';
import 'loginform.dart';

class LoginPage extends StatelessWidget {
  final formlogkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DelayedAnimation(
                      delay: 1500,
                      child: Text(
                        "Connect à votre Compte",
                        style: GoogleFonts.poppins(
                          //color: d_red,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    DelayedAnimation(
                      delay: 2500,
                      child: Text(
                        "It's recommended to connect your email address for us to better protect your information.",
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              Form(key: formlogkey, child: const Loginform()),
              const SizedBox(height: 15),
              DelayedAnimation(
                delay: 5700,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    //primary: d_red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 125,
                      vertical: 13,
                    ),
                  ),
                  child: Text(
                    'REGISTRE',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    Get.to(
                      const Adduser(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(right: 35),
                  child: TextButton(
                    onPressed: () {
                      Get.to(SocialPage());
                    },
                    child: DelayedAnimation(
                      delay: 6500,
                      child: Text(
                        "Retour",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
