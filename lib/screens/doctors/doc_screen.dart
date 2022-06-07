import 'dart:io';

import 'package:animated_horizontal_calendar/animated_horizontal_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:horizontal_time_picker/horizontal_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:reservi/screens/appoimets/booking/booking_controller.dart';
import 'package:reservi/screens/doctors/dr_controller.dart';
import 'package:path/path.dart' as Path;
import 'package:reservi/screens/home/homescreen.dart';

class Drscreen extends StatelessWidget {
  const Drscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DrController());
    Get.put(BookingCtr());
    final TextEditingController Textcontroller = TextEditingController();
    final TextEditingController filecontroller = TextEditingController();
    late PlatformFile file;
    late File _imagefile;
    //Map<String, String> docselected = Get.arguments;
    return Scaffold(
      //extendBody: true,
      //extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 195, 193, 188),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          onPressed: () {
            Get.offAll(const Homepage());
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: const [
          Icon(
            Icons.star_rate_outlined,
            color: Colors.amber,
            size: 34.0,
          )
        ],
      ),
      body: controller.name != null
          ? SafeArea(
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Doctors')
                      .doc(controller.name)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Lottie.asset(
                        'assets/images/loaader.json',
                      ));
                    } else {
                      return Column(children: [
                        GetBuilder<DrController>(builder: (controller) {
                          return Visibility(
                            visible: controller.less.value,
                            child: Container(
                              //margin: const EdgeInsets.only(bottom: 20.0),
                              alignment: Alignment.topCenter,
                              height: 250.0,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.elliptical(30, 8),
                                  bottomRight: Radius.elliptical(30, 8),
                                ),
                                color: Colors.blueAccent,
                              ),
                              child: ListView(shrinkWrap: true, children: [
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 110,
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 15.0, top: 15.0),
                                        margin: const EdgeInsets.only(left: 20),
                                        decoration: const BoxDecoration(
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: Colors.greenAccent,
                                                offset: Offset(
                                                  5.0,
                                                  5.0,
                                                ),
                                                blurRadius: 10.0,
                                                spreadRadius: 2.0,
                                              ), //BoxShadow
                                              BoxShadow(
                                                color: Colors.white,
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 0.0,
                                                spreadRadius: 0.0,
                                              )
                                            ]),
                                        child: Image(
                                          image: NetworkImage(
                                              snapshot.data!['image']),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            snapshot.data!['nomdocteur'],
                                            style: GoogleFonts.acme(
                                                fontSize: 24.0),
                                          ),
                                          Text(
                                            snapshot.data!['Specialit'],
                                            style: GoogleFonts.abel(
                                                fontSize: 18.0,
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                  child: IconButton(
                                                    onPressed: () async {
                                                      await controller
                                                          .callnumber(
                                                              numero: snapshot
                                                                  .data![
                                                                      'phone']
                                                                  .toString());
                                                    },
                                                    icon:
                                                        const Icon(Icons.phone),
                                                  )),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              const CircleAvatar(
                                                  child: Icon(Icons.message))
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      height: 90,
                                      width: 90,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        color: Colors.white,
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Expériance',
                                            style: GoogleFonts.abel(
                                                fontSize: 18.0,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            snapshot.data!['Experience']
                                                    .toString() +
                                                ' ' +
                                                'ans',
                                            style: GoogleFonts.roboto(
                                                fontSize: 24.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 90,
                                      width: 90,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        color: Colors.white,
                                      ),
                                      alignment: Alignment.center,
                                      child: IntrinsicWidth(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Rate',
                                              style: GoogleFonts.abel(
                                                  fontSize: 18.0,
                                                  color: Colors.grey),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  snapshot.data!['rate']
                                                      .toString(),
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 24.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                const Icon(
                                                  Icons.star_rate_sharp,
                                                  color: Colors.amber,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 90,
                                      width: 90,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        color: Colors.white,
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Patient',
                                            style: GoogleFonts.abel(
                                                fontSize: 18.0,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            snapshot.data!['patient']
                                                    .toString() +
                                                ' ' +
                                                '+',
                                            style: GoogleFonts.roboto(
                                                fontSize: 24.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          );
                        }),
                        GetBuilder<DrController>(builder: (controller) {
                          return GestureDetector(
                            onTapUp: (details) {
                              print(controller.less.value);
                              controller.onswitchshow();
                            },
                            child: Container(
                                //color: Colors.white,

                                //padding: const EdgeInsets.only(top: 230),

                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                ),
                                alignment: Alignment.center,
                                // margin: const EdgeInsets.only(top: 0),
                                child: controller.showmororless
                                    ? const Center(
                                        child: Icon(
                                          Icons.keyboard_double_arrow_up,
                                          size: 20.0,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Center(
                                        child: Icon(
                                          Icons.keyboard_double_arrow_down,
                                          size: 20.0,
                                          color: Colors.white,
                                        ),
                                      )),
                          );
                        }),
                        GetBuilder<DrController>(builder: (controller) {
                          return controller.latitude != null
                              ? Expanded(
                                  child: Container(
                                    child: GetBuilder<DrController>(
                                        builder: (controller) {
                                      return GoogleMap(
                                        onMapCreated: (GoogleMapController
                                            controller) async {},
                                        initialCameraPosition: CameraPosition(
                                            target: LatLng(controller.latitude,
                                                controller.longitude),
                                            zoom: 11.0),
                                        mapType: MapType.normal,
                                        markers: Set.of(controller.marker),
                                      );
                                    }),
                                  ),
                                )
                              : Container(
                                  child: const Center(
                                      child: CircularProgressIndicator()),
                                );
                        })
                      ]);
                    }
                  }),
            )
          : Center(child: Lottie.asset('assets/images/loaader.json')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.defaultDialog(
            title: controller.docnfo[0]['nomdocteur'],
            content: Container(
              width: double.infinity,
              height: 500,
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      'Selectionner La date du Rendez-Vous :',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: AnimatedHorizontalCalendar(
                      date: DateTime.now(),
                      tableCalenderIcon: const Icon(Icons.calendar_view_day),
                      onDateSelected: (date) {
                        Get.find<BookingCtr>().daterdv(date);
                        print(Get.find<BookingCtr>().rendivous.value);
                      },
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                    child: Text(
                      'Selectionner L\'Heur du Rendez-Vous :',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: HorizontalTimePicker(
                        onTimeSelected: ((dateTime) {
                          Get.find<BookingCtr>()
                              .datefinal(DateFormat.Hm().format(dateTime));
                          print(Get.find<BookingCtr>().rendivous.value);
                        }),
                        startTimeInHour: 9,
                        endTimeInHour: 20,
                        dateForTime: DateTime.now(),
                        timeIntervalInMinutes: 20,
                        selectedTimeTextStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Helvetica Neue",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.0,
                        ),
                        timeTextStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Helvetica Neue",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.0,
                        ),
                        defaultDecoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border.fromBorderSide(BorderSide(
                            color: Color.fromARGB(255, 151, 151, 151),
                            width: 1,
                            style: BorderStyle.solid,
                          )),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        selectedDecoration: const BoxDecoration(
                          color: Colors.blue,
                          border: Border.fromBorderSide(BorderSide(
                            color: Color.fromARGB(255, 151, 151, 151),
                            width: 1,
                            style: BorderStyle.solid,
                          )),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        disabledDecoration: const BoxDecoration(
                          color: Colors.black26,
                          border: Border.fromBorderSide(BorderSide(
                            color: Color.fromARGB(255, 151, 151, 151),
                            width: 1,
                            style: BorderStyle.solid,
                          )),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 3, left: 10),
                    child: Text(
                      "Ajouter un atachement (Facultatif) !",
                      style: GoogleFonts.poppins(
                        //color: d_red,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IntrinsicWidth(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: TextFormField(
                                  controller: filecontroller,
                                  decoration: const InputDecoration(
                                    //label: Text(nom.toString()),
                                    enabled: false,
                                    hintText: 'parcourir  :pdf ,jpg...',
                                    alignLabelWithHint: true,
                                    floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                  ),
                                ),
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            return const Color.fromARGB(
                                                255, 22, 110, 209);
                                            // Use the component's default.
                                          },
                                        ),
                                      ),
                                      onPressed: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform
                                                .pickFiles();

                                        if (result != null) {
                                          file = result.files.first;
                                          filecontroller.text = file.name;
                                          String imagename = Path.basename(
                                              file.path.toString());
                                          _imagefile =
                                              File(file.path.toString());
                                          Reference firebaseStorageRef =
                                              FirebaseStorage.instance
                                                  .ref()
                                                  .child("Docs/$imagename");
                                          UploadTask uploadtask =
                                              firebaseStorageRef
                                                  .putFile(_imagefile);
                                          uploadtask.then((res) {
                                            res.ref
                                                .getDownloadURL()
                                                .then((value) async {
                                              print(value);
                                              Get.find<BookingCtr>()
                                                  .file
                                                  .value = '';
                                              Get.find<BookingCtr>()
                                                  .getfile(value);
                                            });
                                          });
                                          print(file.name);
                                          print(file.bytes);
                                          print(file.size);
                                          print(file.extension);
                                          print(file.bytes);
                                        } else {
                                          // User canceled the picker
                                        }
                                      },
                                      child: const Text(
                                        'parcourir',
                                        maxLines: 1,
                                      ))),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            child: TextFormField(
                              minLines: 2,
                              maxLines: 2,
                              controller: Textcontroller,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Joindre un Message',
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.start,
                                //label: const Text('Joindre un message'),
                                //enabled: false,
                                disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      //color: Colors.brown,
                                      // width: 3,
                                      ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      //color: Colors.brown,
                                      //width: 3,
                                      ),
                                  borderRadius: BorderRadius.circular(1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      //color: Colors.brown,
                                      //width: 3,
                                      ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            confirm: Container(
              // margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return const Color.fromARGB(255, 2, 116, 26);
                      // Use the component's default.
                    },
                  )),
                  onPressed: () {
                    Get.find<BookingCtr>().storeRdv(
                        context: context,
                        docid: controller.docnfo[0]['ID'],
                        daterdv: Get.find<BookingCtr>().rendivous.value,
                        message: Textcontroller.text,
                        file: Get.find<BookingCtr>().file.value);
                  },
                  child: const Text('Confirme')),
            ),
            cancel: Container(
              // margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return const Color.fromARGB(255, 244, 38, 38);
                      // Use the component's default.
                    },
                  )),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Annuler')),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Demander Rendez-vous'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
