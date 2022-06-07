import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservi/screens/registre/Adduser_controller.dart';
import 'package:reservi/screens/registre/RegistreForm.dart';

import '../shared/delay.dart';

class Adduser extends StatelessWidget {
  const Adduser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    final controller = Get.put(AdduserCtr());

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
                        "Créer un noveau  Compte",
                        style: GoogleFonts.poppins(
                          //color: d_red,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                  ],
                ),
              ),
              Form(key: formkey, child: const Registreform()),
              const SizedBox(height: 35),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(right: 35),
                  child: TextButton(
                    onPressed: () {
                      Get.back();
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
