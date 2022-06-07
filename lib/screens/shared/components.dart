import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

Widget action() {
  return GridView.count(
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    crossAxisCount: 2,
    //scrollDirection: Axis.vertical,
    //shrinkWrap: true,
    padding: const EdgeInsets.all(7),
    children: const <Widget>[],
  );
}

Widget box() {
  return Container(
    padding: const EdgeInsets.all(5),
    width: 50.0,
    height: 50.0,
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.blue[800],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), //color of shadow
            spreadRadius: 5, //spread radius
            blurRadius: 7, // blur radius
            offset: const Offset(0, 2), // changes position of shadow
            //first paramerter of offset is left-right
            //second parameter is top to down
          ),
          //you can set more BoxShadow() here
        ]),
    child: Column(
      children: const [
        Icon(
          Icons.account_balance,
          size: 70.0,
          color: Colors.white70,
        ),
        Text(
          'Administration',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ),
  );
}

Widget button(
    {required Color color,
    required String label,
    required IconData icon,
    required VoidCallback function}) {
  return Container(
    width: 160.0,
    height: 70.0,
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.blueGrey[100],
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), //color of shadow
            spreadRadius: 5, //spread radius
            blurRadius: 7, // blur radius
            offset: const Offset(0, 2), // changes position of shadow
            //first paramerter of offset is left-right
            //second parameter is top to down
          ),
          //you can set more BoxShadow() here
        ]),
    child: Row(
      //mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 120,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: color,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(30), topLeft: Radius.circular(15)),
          ),
          child: Center(
            child: TextButton(
              onPressed: function,
              child: FittedBox(
                child: Text(label,
                    style: GoogleFonts.oswald(
                      color: Colors.black,
                      fontSize: 18.0,
                      //fontWeight: FontWeight.w600,
                    )),
              ),
            ),
          ),
        ),
        Icon(
          icon,
          size: 30.0,
          color: Colors.black,
        )
      ],
    ),
  );
}

Widget menu() {
  return ListView(
    children: const [
      //button(),
    ],
  );
}

Widget Cardss() {
  return Container(
    width: 220.0,
    height: 120.0,
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.grey[400],
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), //color of shadow
            spreadRadius: 5, //spread radius
            blurRadius: 7, // blur radius
            offset: const Offset(0, 2), // changes position of shadow
            //first paramerter of offset is left-right
            //second parameter is top to down
          ),
          //you can set more BoxShadow() here
        ]),
  );
}

Widget title(context) {
  return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'RSER',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.bodyText1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: const Color(0xffe46b10),
          ),
          children: const [
            TextSpan(
              text: 'VI',
              style: TextStyle(color: Colors.black, fontSize: 30),
            )
          ]));
}

Widget entryField(
    {required Icon prefix,
    required IconButton? soufix,
    required String label,
    required TextInputType keyboard,
    required FormFieldValidator validate,
    required TextEditingController ctr,
    required String title,
    required bool securetext,
    required bool isPassword}) {
  return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 45.0,
              child: TextFormField(
                  controller: ctr,
                  validator: validate,
                  keyboardType: keyboard,
                  obscureText: securetext,
                  decoration: InputDecoration(
                      prefixIcon: prefix,
                      suffixIcon: soufix,
                      labelText: label,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      fillColor: const Color(0xfff3f3f4),
                      filled: true)),
            )
          ]));
}

Widget drpeddown(List itmes, var first, void fonction(var val)) {
  //var first = itmes[0];
  return DropdownButton(
    items: itmes.map<DropdownMenuItem<String>>((e) {
      return DropdownMenuItem<String>(
        child: Text(e),
        value: e,
      );
    }).toList(),
    hint: const Text('quelle est votre commune'),
    onChanged: fonction,
    value: first,
  );
}

Widget waver() {
  return WaveWidget(
    config: CustomConfig(
      gradients: [
        [Colors.red, const Color(0xEEF44336)],
        [Colors.blue, const Color(0x77E57373)],
        [Colors.orange, const Color(0x66FF9800)],
        [Colors.yellow, const Color(0x55FFEB3B)]
      ],
      durations: [35000, 19440, 10800, 6000],
      heightPercentages: [0.20, 0.23, 0.25, 0.30],
      blur: const MaskFilter.blur(BlurStyle.solid, 10),
      gradientBegin: Alignment.bottomLeft,
      gradientEnd: Alignment.topRight,
    ),
    backgroundImage: const DecorationImage(
      image: NetworkImage(
        'https://images.unsplash.com/photo-1600107363560-a2a891080c31?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=672&q=80',
      ),
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(Colors.white, BlendMode.softLight),
    ),
    size: const Size(
      double.infinity,
      double.infinity,
    ),
  );
}
