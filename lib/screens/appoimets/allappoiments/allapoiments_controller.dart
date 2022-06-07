import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListAppCtr extends GetxController {
  var Docname = List.empty(growable: true).obs;
  var Docimg = List.empty(growable: true).obs;
  var alldoc = List.empty(growable: true).obs;
  var allapp = 0.obs;
  var wapp = 0.obs;
  var aapp = 0.obs;
  var stram;
  var length = 0.obs;
  load() async {
    stram = FirebaseFirestore.instance
        .collection('Appoiament')
        .where('UserID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      alldoc.value = value.docs;
      update();
    });
  }

  lengeur({required int index}) {
    length.value = index;

    return length.value;
  }

  String docinfo({required String iddoc, required int index}) {
    FirebaseFirestore.instance
        .collection('Doctors')
        .where('ID', isEqualTo: iddoc)
        .get()
        .then((value) {
      Docname.add(value.docs[0]['nomdocteur']);

      //print(value.docs);

      update();
    });
    return Docname[index].toString();
  }

  String docinfoimg({required String iddoc, required int index}) {
    FirebaseFirestore.instance
        .collection('Doctors')
        .where('ID', isEqualTo: iddoc)
        .get()
        .then((value) {
      Docimg.add(value.docs[0]['image']);

      //print(value.docs);

      update();
      for (var res in Docimg) {}
    });
    return Docimg[index].toString();
  }

  state(
      {required String etat,
      required String rdiid,
      required BuildContext context}) {
    if (etat == 'wating') {
      return Container(
        height: 8,
        width: 8,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(30)),
      );
    } else if (etat == 'Accepted') {
      return Container(
        height: 8,
        width: 8,
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(30)),
      );
    } else if (etat == 'done') {
      return GestureDetector(
        onTap: () async {
          await FirebaseFirestore.instance
              .collection("Appoiament")
              .doc(rdiid)
              .delete()
              .then((value) {
            AwesomeDialog(
              context: context,
              //body: const Text('Rendez-vous supprimer avec suucces'),
              showCloseIcon: true,
              title: 'Rendez-vous supprimer avec suucces',
            ).show();
          });
        },
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircleAvatar(
            backgroundColor: Colors.grey[100],
            child: const Icon(Icons.delete_forever_outlined),
          ),
        ),
      );
    }
  }

  ondeleteapp({required String Rdvid}) {
    FirebaseFirestore.instance
        .collection("Appoiament")
        .where("RdvId", isEqualTo: Rdvid)
        .get()
        .then((value) {
      for (var element in value.docs) {
        FirebaseFirestore.instance
            .collection("Appoiament")
            .doc(element.id)
            .delete()
            .then((value) {
          print("Success!");
        });
      }
    });
  }

  counter() async {
    await FirebaseFirestore.instance
        .collection('Appoiament')
        .where('UserID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      final List<DocumentSnapshot> documents = value.docs;

      allapp.value = documents.length;
      for (int i = 0; i < documents.length; i++) {
        documents[i]['Etat'] == 'wating' ? increesw() : increesa();
      }
    });
  }

  increesw() {
    wapp.value++;
    update();
  }

  increesa() {
    aapp.value++;
    update();
  }

  @override
  void onInit() async {
    await counter();
    await load();

    // TODO: implement onInit
    super.onInit();
  }
}
