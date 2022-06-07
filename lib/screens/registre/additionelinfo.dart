import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservi/screens/registre/additionelinfo_controller.dart';

import '../shared/delay.dart';
import 'additionlform.dart';

class Additionlinfo extends StatelessWidget {
  const Additionlinfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    final controller = Get.put(additionlinfoCtr());

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
                        "Continuer votre enreistrement",
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
              Form(key: formkey, child: const AdditionlForm()),
              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}
