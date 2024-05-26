import 'dart:io';
import 'package:deptechcodingtest/view/Event/controller/EventController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/SharedPreferences.dart';
import '../../../data/local/model/event.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final EventController controller = Get.find();
  Event event = Get.arguments["event"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset(
            "assets/logo.png",
            width: 70,
            height: 70,
          ),
          centerTitle: true,
        ),
        body: GetBuilder<EventController>(builder: (controller) {
          if (controller.loading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else {
            return RefreshIndicator(
                child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: event.pic != null
                                  ? Image.file(
                                File(event.pic!),
                                scale: 0.5,
                                fit: BoxFit.cover,
                              )
                                  : Image.asset(
                                  "assets/placeholder.png"),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            itemProfileDetail("Judul Agenda", event.title ?? "Nobar Haikyuu"),
                            itemProfileDetail("Deskripsi Agenda",event.desc ?? "Nobar di CGV GI"),
                            itemProfileDetail("Tanggal Agenda", event.date ?? "24 Mei 2024"),
                            itemProfileDetail("Waktu Agenda", event.time ?? "17.00 WIB"),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.editEvent, arguments: {"event" : event});
                                },
                                child: Text("Edit Event", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Color(0XFF3B3C8C),

                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    )),
                onRefresh: () async {});
          }
        }));
  }

  Widget itemProfileDetail(String title, String data){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title,style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16
        ),),
        Text(data),
      ],
    );
  }
}
