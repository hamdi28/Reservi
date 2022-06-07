import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservi/screens/Login/login_controller.dart';

import '../shared/delay.dart';

class Loginform extends StatelessWidget {
  const Loginform({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LogController());
    //var info = Get.parameters;
    final box = GetStorage();
    final formlogkey = GlobalKey<FormState>();

    var emailcontroller = TextEditingController();

    var paaswordcontroller = TextEditingController();

    return GetBuilder<LogController>(builder: (controller) {
      emailcontroller.text = box.read('email');
      paaswordcontroller.text = box.read('pass');
      return Form(
        key: formlogkey,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            children: [
              DelayedAnimation(
                delay: 3500,
                child: TextFormField(
                  onChanged: (Value) {
                    emailcontroller.text = Value;
                  },
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
              const SizedBox(height: 30),
              DelayedAnimation(
                delay: 3510,
                child: TextFormField(
                  /*onChanged: (Value) {
                    paaswordcontroller.text = Value;
                  },*/
                  controller: paaswordcontroller,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Faible Password au moin 6 chiffre ';
                    } else {
                      return null;
                    }
                  },
                  obscureText: controller.secure.value,
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
                delay: 3520,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    //primary: d_red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 115,
                      vertical: 13,
                    ),
                  ),
                  child: FittedBox(
                    child: Text(
                      'CONFIRM',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (formlogkey.currentState!.validate()) {
                      try {
                        await controller.signin(
                            context: context,
                            email: emailcontroller.text,
                            pass: paaswordcontroller.text);
                        //Get.to(const Searchscreen());
                      } catch (e) {}
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
