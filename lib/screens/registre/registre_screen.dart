import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservi/screens/registre/registre_controller.dart';
import 'package:reservi/screens/shared/components.dart';
import 'package:submit_button/submit_button.dart';
import 'package:hexcolor/hexcolor.dart';

class RegistreScreen extends StatelessWidget {
  const RegistreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistreConttroller());
    var formkey = GlobalKey<FormState>();
    var namecontroller = TextEditingController();
    var prebomcontroller = TextEditingController();

    var Phonecontroller = TextEditingController();
    var emailcontroller = TextEditingController();
    var adressecontroller = TextEditingController();

    var paaswordcontroller = TextEditingController();

    var commcontroller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: title(context),
        elevation: 0.0,
        backgroundColor: Colors.blueAccent,
        //excludeHeaderSemantics: true,

        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 28.0,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                alignment: Alignment.topCenter,
                height: 150.0,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(30, 8),
                    bottomRight: Radius.elliptical(30, 8),
                  ),
                  color: Colors.blueAccent,
                ),
                child: Image.asset("assets/images/aply.png"),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Form(
                    child: Column(
                  children: [
                    entryField(
                        prefix: const Icon(Icons.email),
                        soufix: IconButton(
                            onPressed: () {}, icon: const Icon(null)),
                        label: 'Enter Votre Email...',
                        keyboard: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'Adresse Email non valide';
                          } else {
                            return null;
                          }
                        },
                        ctr: emailcontroller,
                        title: 'Email :',
                        securetext: false,
                        isPassword: false),
                    entryField(
                        prefix: const Icon(Icons.lock),
                        soufix: IconButton(
                            onPressed: () {
                              print(controller.ispas);
                            },
                            icon: Icon(controller.ispas != false
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        label: 'Enter Votre Password...',
                        keyboard: TextInputType.text,
                        validate: (value) {
                          //String text = 'xx';
                          if (value!.isEmpty || value.toString().length < 6) {
                            return 'Password non valide';
                          } else {
                            return null;
                          }
                        },
                        ctr: paaswordcontroller,
                        title: 'Password :',
                        securetext: controller.ispas,
                        isPassword: true),
                    SubmitButton(
                      isLoading: false,
                      spinnerColor: Colors.white,
                      backgroundColor: HexColor('#292A64'),
                      button: TextButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              try {
                                //controller.startload();
                                await controller
                                    .signup(
                                        context: context,
                                        nom: namecontroller.text,
                                        prenom: prebomcontroller.text,
                                        email: emailcontroller.text,
                                        phone: Phonecontroller.text,
                                        password: paaswordcontroller.text,
                                        adresse: controller.defaultselected)
                                    .then((value) {
                                  //Get.back();
                                });
                              } catch (e) {}

                              // controller.startload();
                            } else {
                              //controller.startload();
                              print(controller.defaultselected);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Icon(Icons.login),
                              GetBuilder<RegistreConttroller>(
                                builder: (controller) {
                                  return const FittedBox(child: Text('Login'));
                                },
                              )
                            ],
                          )),
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'Vous-avez déja un Compte!',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12),
                            children: [
                              TextSpan(
                                text: ' Mot de passe oublier ?',
                                style: GoogleFonts.portLligatSans(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xffe46b10),
                                ),
                                onEnter: (event) {
                                  //Get.to(LoginScreen());
                                },
                              ),
                            ]))
                  ],
                )),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => buildsheet(context: context),
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10))));
        },
        icon: const Icon(Icons.person_add),
        label: const Text('Registre'),
      ),
      //bottomSheet:butto ,
    );
  }
}

Widget buildsheet({
  required BuildContext context,
}) {
  final controller = Get.put(RegistreConttroller());

  var formkey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  var prebomcontroller = TextEditingController();

  var Phonecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var adressecontroller = TextEditingController();
  var _controller = ScrollController;

  var paaswordcontroller = TextEditingController();

  var commcontroller = TextEditingController();
  return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, _controller) {
        return SingleChildScrollView(
          child: Container(
              //final controller = Get.put(RegistreConttroller());
              padding: const EdgeInsets.all(10),
              child: Form(
                  key: formkey,
                  child: ListView(
                    children: [
                      title(context),
                      entryField(
                          prefix: const Icon(Icons.person),
                          soufix: IconButton(
                              onPressed: () {}, icon: const Icon(null)),
                          label: 'Enter Votre Nom...',
                          keyboard: TextInputType.text,
                          validate: (value) {
                            String text = '';
                            if (value!.isEmpty) {
                              return 'Veuiller Remplir se champ ';
                            } else {
                              return null;
                            }
                          },
                          ctr: namecontroller,
                          title: 'Nom :',
                          securetext: false,
                          isPassword: false),
                      entryField(
                          prefix: const Icon(Icons.person),
                          soufix: IconButton(
                              onPressed: () {}, icon: const Icon(null)),
                          label: 'Enter Votre Prénom...',
                          keyboard: TextInputType.text,
                          validate: (value) {
                            String text = '';
                            if (value!.isEmpty) {
                              return 'Veuiller Remplir se champ ';
                            } else {
                              return null;
                            }
                          },
                          ctr: prebomcontroller,
                          title: 'Prénom :',
                          securetext: false,
                          isPassword: false),
                      entryField(
                          prefix: const Icon(Icons.phone_android_outlined),
                          soufix: IconButton(
                              onPressed: () {}, icon: const Icon(null)),
                          label: 'Enter Votre Num Telephone...',
                          keyboard: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Veuiller Remplir se champ ';
                            } else {
                              return null;
                            }
                          },
                          ctr: adressecontroller,
                          title: 'Adresse :',
                          securetext: false,
                          isPassword: false),
                      entryField(
                          prefix: const Icon(Icons.location_city),
                          soufix: IconButton(
                              onPressed: () {}, icon: const Icon(null)),
                          label: 'Enter Votre adresse...',
                          keyboard: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Veuiller Remplir se champ ';
                            } else {
                              return null;
                            }
                          },
                          ctr: Phonecontroller,
                          title: 'Phone :',
                          securetext: false,
                          isPassword: false),
                      entryField(
                          prefix: const Icon(Icons.email),
                          soufix: IconButton(
                              onPressed: () {}, icon: const Icon(null)),
                          label: 'Enter Votre Email...',
                          keyboard: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return 'Adresse Email non valide';
                            } else {
                              return null;
                            }
                          },
                          ctr: emailcontroller,
                          title: 'Email :',
                          securetext: false,
                          isPassword: false),
                      entryField(
                          prefix: const Icon(Icons.lock),
                          soufix: IconButton(
                              onPressed: () {
                                print(controller.ispas);
                              },
                              icon: Icon(controller.ispas != false
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          label: 'Enter Votre Password...',
                          keyboard: TextInputType.text,
                          validate: (value) {
                            //String text = 'xx';
                            if (value!.isEmpty || value.toString().length < 6) {
                              return 'Password non valide';
                            } else {
                              return null;
                            }
                          },
                          ctr: paaswordcontroller,
                          title: 'Password :',
                          securetext: controller.ispas,
                          isPassword: true),
                      SubmitButton(
                        isLoading: false,
                        spinnerColor: Colors.white,
                        backgroundColor: HexColor('#292A64'),
                        button: TextButton(
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                try {
                                  //navigator.pop(context);
                                  await controller.signup(
                                      context: context,
                                      nom: namecontroller.text,
                                      prenom: prebomcontroller.text,
                                      adresse: adressecontroller.text,
                                      phone: Phonecontroller.text,
                                      email: emailcontroller.text,
                                      password: paaswordcontroller.text);
                                } catch (e) {}
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Icon(Icons.login),
                                GetBuilder<RegistreConttroller>(
                                  builder: (controller) {
                                    return const FittedBox(
                                        child: Text('Registre'));
                                  },
                                )
                              ],
                            )),
                      ),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: 'Vous-avez déja un Compte?',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                              children: [
                                TextSpan(
                                  text: ' Connecter',
                                  style: GoogleFonts.portLligatSans(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText1,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xffe46b10),
                                  ),
                                  onEnter: (event) {
                                    //Get.to(LoginScreen());
                                  },
                                ),
                              ]))
                    ],
                  ))),
        );
      });
}
