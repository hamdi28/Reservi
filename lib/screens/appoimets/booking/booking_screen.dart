/*import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_time_picker/horizontal_time_picker.dart';
import 'package:horizontalcalender/extra/color.dart';
import 'package:horizontalcalender/horizontalcalendar.dart';
import 'package:intl/intl.dart';
import 'package:reservi/screens/appoimets/booking/booking_controller.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController Textcontroller = TextEditingController();
    late PlatformFile file;

    final TextEditingController filecontroller = TextEditingController();
    var nom = FirebaseAuth.instance.currentUser!.email;
    var tt = FirebaseAuth.instance.currentUser!.uid;
    final FixedExtentScrollController itemController =
        FixedExtentScrollController();
    final controller = Get.put(BookingCtr());
    final islaststep = controller.currentstep.value;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rendez-Vous'),
          titleTextStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: GetBuilder<BookingCtr>(builder: (controller) {
          return Container(
            height: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Visibility(
                  visible: controller.showtext.value,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    alignment: Alignment.topCenter,
                    height: 250.0,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(30, 8),
                        bottomRight: Radius.elliptical(30, 8),
                      ),
                      color: Colors.blueAccent,
                    ),
                    child: Image.asset("assets/images/appointment.jpg"),
                  ),
                ),
                Container(
                  // color: Colors.white.withOpacity(0.8),
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text(tt.toString()),
                      enabled: false,
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            //color: Colors.white,
                            //width: 3,
                            ),
                        borderRadius: BorderRadius.circular(1),
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
                const SizedBox(height: 15.0),
                Visibility(
                  visible: controller.show.value,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(height: 300.0),
                    child: Stepper(
                      controlsBuilder: (context, details) {
                        return Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        final islaststep =
                                            controller.currentstep.value;
                                        if (islaststep >= 2) {
                                          controller.unshow();
                                        } else {
                                          controller.forward();
                                        }
                                      },
                                      child: Text(islaststep == 2
                                          ? 'Confirmer'
                                          : 'Suivant'))),
                              const SizedBox(
                                width: 12,
                              ),
                              if (controller.currentstep.value != 0)
                                Expanded(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          controller.currentstep.value == 0
                                              ? null
                                              : controller.backword();
                                        },
                                        child: const Text('Retour'))),
                            ],
                          ),
                        );
                      },
                      steps: [
                        Step(
                            state: controller.currentstep.value > 0
                                ? StepState.complete
                                : StepState.indexed,
                            title: const Text('Jour'),
                            content: HorizontalCalendar(
                              DateTime.now(),
                              inactiveDates: const [],
                              onDateChange: (datettime, x) {
                                controller.daterdv(
                                    DateFormat.yMMMMd().format(datettime));
                                print(controller.rendivous.value);
                              },
                              itemController: itemController,
                              daysCount: 7,
                              height: 110,
                              monthTextStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Helvetica Neue",
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                height: 1.0,
                              ),
                              deactivatedColor:
                                  AppColors.defaultDeactivatedColor,
                              dateTextStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Helvetica Neue",
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                height: 1.0,
                              ),
                              dayTextStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Helvetica Neue",
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                height: 1.0,
                              ),
                              selectedDateStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Helvetica Neue",
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                height: 1.0,
                              ),
                              selectedDayStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Helvetica Neue",
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                height: 1.0,
                              ),
                              width: MediaQuery.of(context).size.width * 0.25,
                            ),
                            isActive: controller.currentstep.value >= 0),
                        Step(
                            state: controller.currentstep.value == 1
                                ? StepState.complete
                                : StepState.indexed,
                            title: const Text('Heure'),
                            content: HorizontalTimePicker(
                              onTimeSelected: ((dateTime) {
                                controller.datefinal(
                                    DateFormat.Hm().format(dateTime));
                                print(controller.rendivous.value);
                              }),
                              startTimeInHour: 9,
                              endTimeInHour: 17,
                              timeIntervalInMinutes: 20,
                              dateForTime: DateTime.now(),
                              initialSelectedDates: null,
                              selectedTimeTextStyle: const TextStyle(
                                color: Colors.white,
                                fontFamily: "Helvetica Neue",
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                height: 1.0,
                              ),
                              timeTextStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Helvetica Neue",
                                fontWeight: FontWeight.w300,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              selectedDecoration: const BoxDecoration(
                                color: Colors.black,
                                border: Border.fromBorderSide(BorderSide(
                                  color: Color.fromARGB(255, 151, 151, 151),
                                  width: 1,
                                  style: BorderStyle.solid,
                                )),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              disabledDecoration: const BoxDecoration(
                                color: Colors.black26,
                                border: Border.fromBorderSide(BorderSide(
                                  color: Color.fromARGB(255, 151, 151, 151),
                                  width: 1,
                                  style: BorderStyle.solid,
                                )),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              height: 50,
                            ),
                            isActive: controller.currentstep.value >= 1),
                        Step(
                            title: const Text('Valider'),
                            content: Container(
                              child: Text(controller.rendivous.value),
                            ),
                            isActive: controller.currentstep.value >= 2),
                      ],
                      type: StepperType.horizontal,
                      currentStep: controller.currentstep.value,
                      onStepContinue: () {
                        if (islaststep >= 2) {
                          print('test');
                        } else {
                          controller.forward();
                        }
                      },
                      onStepCancel: () {
                        controller.currentstep.value == 0
                            ? null
                            : controller.backword();
                      },
                      onStepTapped: (Step) =>
                          controller.currentstep.value = Step,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Visibility(
                  visible: controller.showtext.value,
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text('Le ${controller.rendivous.value}'),
                      labelStyle: GoogleFonts.poppins(fontSize: 20.0),
                      enabled: false,
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            //color: Colors.brown,
                            //width: 3,
                            ),
                        borderRadius: BorderRadius.circular(1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            //color: Colors.brown,
                            // width: 3,
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
                            // color: Colors.red,
                            // width: 2,
                            ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  minLines: 5,
                  maxLines: 5,
                  controller: Textcontroller,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: 'Joindre un Message',
                    floatingLabelAlignment: FloatingLabelAlignment.start,
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
                const SizedBox(
                  height: 20,
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
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
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return const Color.fromARGB(255, 132, 130, 130);
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
                          label: const Text('Joindre un Ficher'))
                    ],
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      ElevatedButton.icon(
                          onPressed: () async {
                            Reference Firebassotrageref = FirebaseStorage
                                .instance
                                .ref('Docs/${file.name}');
                          },
                          icon: const Icon(
                            Icons.download_done_sharp,
                            color: Colors.green,
                          ),
                          label: const Text('Confirmer')),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: Colors.red,
                          ),
                          label: const Text('Annuller'))
                    ],
                  ),
                )
              ],
            ),
          );
        }));
  }
}
*/