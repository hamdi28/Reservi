import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservi/Faq/fac_controller.dart';
import 'package:reservi/screens/home/homescreen.dart';
import 'package:reservi/screens/shared/animation.dart';
import 'package:reservi/screens/shared/delay.dart';
import 'package:reservi/screens/user/profile/profile_controller.dart';
import 'package:reservi/screens/user/profile/profile_screen.dart';

class SettigScreen extends StatelessWidget {
  const SettigScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileCtr());
    List user = Get.find<ProfileCtr>().myinfo;
    var qcontroller = TextEditingController();
    final controller = Get.put(FaqCtr());

    return GetBuilder<FaqCtr>(builder: (controller) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
              margin: const EdgeInsets.only(top: 20),
              height: double.maxFinite,
              width: double.maxFinite,
              child: ListView(shrinkWrap: true, children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(const ProfileScreen());
                              },
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage('${user[0]['photoUrl']}'),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            FittedBox(
                                child: Text(
                              '${user[0]['Nom']}',
                              maxLines: 1,
                              style: GoogleFonts.poppins(
                                fontSize: 20.0,
                              ),
                            ))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAll(const Homepage());
                        },
                        child: const DelayedAnimation(
                          delay: 1500,
                          child: ImageRotate(
                            child: CircleAvatar(
                              //maxRadius: 50,
                              //height: 170,
                              backgroundImage:
                                  AssetImage('assets/images/luncion.png'),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ])));
    });
  }
}
