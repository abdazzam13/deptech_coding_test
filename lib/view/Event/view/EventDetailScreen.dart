import 'dart:io';
import 'package:deptechcodingtest/view/Event/controller/EventController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../data/local/model/event.dart';
import '../../component/itemDetail.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final EventController controller = Get.find();
  Event event = Get.arguments["event"];

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
                          child: Column(
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
                                    : Image.asset("assets/placeholder.png"),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              itemDetail(
                                  title: "Judul Agenda",
                                  data: event.title ?? "Nobar Haikyuu"),
                              itemDetail(
                                  title: "Deskripsi Agenda",
                                  data: event.desc ?? "Nobar di CGV GI"),
                              itemDetail(
                                  title: "Tanggal Agenda",
                                  data: event.date ?? "24 Mei 2024"),
                              itemDetail(
                                  title: "Waktu Agenda",
                                  data: event.time ?? "17.00 WIB"),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed(AppRoutes.editEvent,
                                        arguments: {"event": event});
                                  },
                                  child: Text(
                                    "Edit Event",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Color(0XFF3B3C8C),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))),
                onRefresh: () async {});
          }
        }));
  }
}
