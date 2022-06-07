import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:reservi/screens/Login/login_controller.dart';
import 'package:reservi/screens/registre/Adduser_controller.dart';

import '../shared/delay.dart';

class Registreform extends StatelessWidget {
  const Registreform({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LogController());
    final formkey = GlobalKey<FormState>();
    var namecontroller = TextEditingController();
    var prenomcontroller = TextEditingController();

    var phonecontroller = TextEditingController();
    var emailcontroller = TextEditingController();

    var paaswordcontroller = TextEditingController();
    //var controller = Get.put(AdduserCtr());

    return GetBuilder<AdduserCtr>(builder: (controller) {
      return Form(
        key: formkey,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            children: [
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
                    labelText: 'Nom',
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
                    labelText: 'Prénom',
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
                    labelText: 'Numéro',
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
                    labelText: 'Adresse Email',
                    labelStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DelayedAnimation(
                delay: 3540,
                child: TextFormField(
                  controller: paaswordcontroller,
                  obscureText: controller.secure.value,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Faible Password au moin 6 chiffre ';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: controller.secure.value
                          ? const Icon(
                              Icons.visibility,
                              color: Colors.black,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: Colors.black,
                            ),
                      onPressed: () {
                        controller.switching();
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 65),
              DelayedAnimation(
                delay: 5500,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    //primary: d_red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 125,
                      vertical: 13,
                    ),
                  ),
                  child: FittedBox(
                    child: Text(
                      'CONFIRM',
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      try {
                        await controller.registration(
                            context: context,
                            nom: namecontroller.text,
                            prenom: prenomcontroller.text,
                            phone: phonecontroller.text,
                            email: emailcontroller.text,
                            password: paaswordcontroller.text);
                      } catch (e) {
                        MotionToast.error(
                          description: Text(e.toString()),
                          animationDuration: const Duration(milliseconds: 2000),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
