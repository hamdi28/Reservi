import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservi/screens/registre/additionelinfo_controller.dart';

import '../shared/delay.dart';

class AdditionlForm extends StatelessWidget {
  const AdditionlForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(additionlinfoCtr());
    final formkey = GlobalKey<FormState>();
    var namecontroller = TextEditingController();
    var prenomcontroller = TextEditingController();

    var phonecontroller = TextEditingController();

    //var controller = Get.put(AdduserCtr());

    return GetBuilder<additionlinfoCtr>(builder: (controller) {
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
                      await controller.registration(
                          context: context,
                          nom: namecontroller.text,
                          prenom: prenomcontroller.text,
                          phone: phonecontroller.text);
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
