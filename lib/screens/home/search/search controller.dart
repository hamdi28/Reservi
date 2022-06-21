//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Searchcontroller extends GetxController {
  var searchres = List.empty(growable: true).obs;
  var searchdef = List.empty(growable: true).obs;
  var searchid = List.empty(growable: true).obs;
  Map<String, String> docinfo = {};

  getsearch(String query) async {
    FirebaseFirestore.instance
        .collection('Doctors')
        .where('nomdocteur'.toLowerCase(), isGreaterThanOrEqualTo: query)
        .where('nomdocteur'.toLowerCase(), isLessThanOrEqualTo: "$query+\uf7ff")
        .get()
        .then((value) {
      searchres.value = value.docs;
      print(value.docs);

      update();
    });
  }

  stock(index) {
    for (var element in searchres) {
      docinfo = {
        'image': element[index]['image'],
      };
      update();
    }
  }

  getall() async {
    FirebaseFirestore.instance
        .collection('Doctors')
        .orderBy('rate', descending: true)
        .get()
        .then((value) {
      searchdef.value = value.docs;
      /*print(searchres.length);*/

      update();
    });
    // FirebaseFirestore.instance.collection('doctor').doc().id;
  }

  @override
  void onInit() async {
    await getall();

    super.onInit();
  }
}
