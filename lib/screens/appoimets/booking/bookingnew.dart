import 'dart:io';

import 'package:animated_horizontal_calendar/animated_horizontal_calendar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_time_picker/horizontal_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:reservi/screens/appoimets/booking/booking_controller.dart';
import 'package:reservi/screens/home/search/search%20controller.dart';
import 'package:reservi/screens/shared/animation.dart';
import 'package:reservi/screens/shared/delay.dart';
import 'package:reservi/screens/user/profile/profile_controller.dart';
import 'package:path/path.dart' as Path;

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController Textcontroller = TextEditingController();
    late PlatformFile file;

    final TextEditingController filecontroller = TextEditingController();
    var nom = FirebaseAuth.instance.currentUser!.email;
    var tt = FirebaseAuth.instance.currentUser!.uid;
    final FixedExtentScrollController itemController =
        FixedExtentScrollController();
    Get.put(
      ProfileCtr(),
    );
    Get.put(Searchcontroller());
    final controller = Get.put(BookingCtr());
    List user = Get.find<ProfileCtr>().myinfo;
    late File _imagefile;
    List docs = Get.find<Searchcontroller>().searchdef;
    return GetBuilder<BookingCtr>(builder: (conroller) {
      return docs.isNotEmpty
          ? Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                margin: const EdgeInsets.only(top: 20),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Reserver Votre Rendez-vous Maintenent !",
                        style: GoogleFonts.poppins(
                          //color: d_red,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage('${user[0]['photoUrl']}'),
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
                          const DelayedAnimation(
                            delay: 1500,
                            child: ImageRotate(
                              child: CircleAvatar(
                                //maxRadius: 50,
                                //height: 170,
                                backgroundImage:
                                    AssetImage('assets/images/luncion.png'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        'Selectionner Votre Docteur :',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 150,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              controller.slectddoc(index);

                              print(controller.select.value);
                            },
                            child: Container(
                              height: 150,
                              width: 100,
                              margin: const EdgeInsets.only(right: 5),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: 50,
                                  // width: 50,
                                  padding: const EdgeInsets.only(
                                      top: 8, left: 8, right: 2),
                                  decoration: BoxDecoration(
                                    color: controller.select.value == index
                                        ? Colors.blue
                                        : Colors.black.withOpacity(0.8),
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(30)),
                                  ),
                                  child: Text(
                                    '${docs[index]['nomdocteur']}',
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white.withOpacity(0.8),
                                  image: DecorationImage(
                                    image:
                                        NetworkImage('${docs[index]['image']}'),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          );
                        },
                        itemCount: docs.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                          controller.daterdv(date);
                          print(controller.rendivous.value);
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
                            controller
                                .datefinal(DateFormat.Hm().format(dateTime));
                            print(controller.rendivous.value);
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
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5),
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
                                                controller.getfile(value);
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
                    /*Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
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
                              /* ElevatedButton.icon(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        return const Color.fromARGB(
                                            255, 132, 130, 130);
                                        // Use the component's default.
                                      },
                                    ),
                                  ),
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles();

                                    if (result != null) {
                                      file = result.files.first;
                                      filecontroller.text = file.name;

                                      print(file.name);
                                      print(file.bytes);
                                      print(file.size);
                                      print(file.extension);
                                      print(file.bytes);
                                    } else {
                                      // User canceled the picker
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.file_upload_outlined,
                                    color: Colors.black,
                                  ),
                                  label: const Text('Joindre un Ficher'))*/
                            ],
                          ),
                          /* Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Joindre un missage :',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                              ),
                              TextFormField(
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
                            ],
                          )*/
                        ],
                      ),
                    )*/
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: ElevatedButton(
                              style: ButtonStyle(backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return const Color.fromARGB(255, 2, 116, 26);
                                  // Use the component's default.
                                },
                              )),
                              onPressed: () {
                                controller.storeRdv(
                                    context: context,
                                    docid: docs[controller.select.value]['ID'],
                                    daterdv: controller.rendivous.value,
                                    message: Textcontroller.text,
                                    file: controller.file.value);
                              },
                              child: const Text('Confirme')),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: ElevatedButton(
                              style: ButtonStyle(backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
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
                      ],
                    )
                  ],
                ),
              ),
            )
          : const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
    });
  }
}
