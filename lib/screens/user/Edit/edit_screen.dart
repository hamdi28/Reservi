import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservi/screens/user/Edit/edit_controller.dart';

import 'editform.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    List userdata = Get.arguments;
    final controller = Get.put(EditscrenCtr());
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListView(
            shrinkWrap: true,
            children: [
              Form(key: formkey, child: const EditForm()),
              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}
