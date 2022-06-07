import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservi/screens/home/socialpage.dart';

import '../shared/delay.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDECF2),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 60,
            horizontal: 30,
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const DelayedAnimation(
                delay: 1500,
                child: SizedBox(
                  height: 170,
                  width: 170,
                  child: CircleAvatar(
                    //height: 170,
                    backgroundImage: AssetImage('assets/images/luncion.png'),
                  ),
                ),
              ),
              /* DelayedAnimation(
                delay: 2500,
                child: Container(
                  height: 400,
                  child: Image.asset('images/yoga_2.jpeg'),
                ),
              ),*/
              DelayedAnimation(
                delay: 2500,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                  ),
                  child: Text(
                    "Gerer Vos Rndez-Vous En Ligne",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 3500,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(30, 8))),
                  //height: 200,
                  child: Image.asset('assets/images/aply.png'),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              DelayedAnimation(
                delay: 4500,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        //primary: const Color(0xFFE9717D),
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(13)),
                    child: const Text('GET STARTED'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SocialPage(),
                        ),
                      );
                    },
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
