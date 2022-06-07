import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservi/screens/doctors/doc_screen.dart';
import 'package:reservi/screens/home/search/search%20controller.dart';

class Searchscreen extends StatelessWidget {
  const Searchscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Searchcontroller());
    return GetBuilder<Searchcontroller>(
        builder: ((controller) => Scaffold(
              body: SafeArea(
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 5.0,
                    ),
                    SizedBox(
                      //color: Colors.white,
                      width: double.infinity,
                      //padding: EdgeInsets.only(top: 223, left: 55, right: 55),
                      child: TextField(
                        onChanged: (value) {
                          controller.getsearch(value);
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          hintText: 'Example :Dr Foulene',
                          hintStyle: TextStyle(fontSize: 18.0),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 30.0,
                          ),
                          filled: true,
                        ),
                        //onSubmitted :
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    controller.searchres.isEmpty != true
                        ? GetBuilder<Searchcontroller>(builder: (controller) {
                            return ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(controller
                                            .searchres[index]['image']),
                                        //fit: BoxFit.cover,
                                      ),
                                      title: Text(
                                        controller.searchres[index]
                                            ['nomdocteur'],
                                        style: GoogleFonts.lato(
                                            //fontSize: 30,
                                            color: Colors.black),
                                      ),
                                      onTap: () {
                                        String image =
                                            controller.searchdef[index]['id'];

                                        Get.to(const Drscreen(),
                                            arguments: image);
                                      },
                                      subtitle: Text(
                                        controller.searchres[index]['adresse'],
                                        style: GoogleFonts.lato(
                                            //fontSize: 30,
                                            color: Colors.black),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 2.0,
                                  );
                                },
                                itemCount: controller.searchres.length);
                          })
                        : GetBuilder<Searchcontroller>(builder: (controller) {
                            return ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(controller
                                            .searchdef[index]['image']),
                                        //fit: BoxFit.cover,
                                      ),
                                      title: Text(
                                        controller.searchdef[index]
                                            ['nomdocteur'],
                                        style: GoogleFonts.lato(
                                            //fontSize: 30,
                                            color: Colors.black),
                                      ),
                                      onTap: () {
                                        String image =
                                            controller.searchdef[index]['id'];

                                        Get.to(const Drscreen(),
                                            arguments: image);
                                      },
                                      subtitle: Text(
                                        controller.searchdef[index]['adresse'],
                                        style: GoogleFonts.lato(
                                            //fontSize: 30,
                                            color: Colors.black),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 2.0,
                                  );
                                },
                                itemCount: controller.searchdef.length);
                          })
                  ],
                ),
              ),
            )));
  }
}
