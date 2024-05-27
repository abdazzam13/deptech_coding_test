import 'package:deptechcodingtest/view/Event/controller/EventController.dart';
import 'package:deptechcodingtest/view/component/customTextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../data/local/model/event.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final EventController controller = Get.find();
  Event event = Get.arguments["event"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      controller.picture = event.pic != null ? File(event.pic!) : null;
      controller.eventTitleController.text = event.title!;
      controller.eventDescController.text = event.desc!;
      controller.selectedDateController.text = event.date!;
      controller.selectedTimeController.text = event.time!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset(
            "assets/logo.png",
            width: 70,
            height: 70,
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: GetBuilder<EventController>(builder: (controller) {
          if (controller.loading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.lightBlueAccent,
              ),
            );
          } else {
            return RefreshIndicator(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20),
                        child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(48), // Image radius
                                      child: controller.picture != null
                                          ? Image.file(
                                              controller.picture!,
                                              scale: 0.5,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              "assets/placeholder.png"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      bool? isCamera = await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  controller
                                                      .takePictureWithCamera();
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Camera"),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  controller
                                                      .pickImageFromGallery();
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Gallery"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                      isCamera!
                                          ? controller.takePictureWithCamera()
                                          : controller.pickImageFromGallery();
                                    },
                                    child: Icon(Icons.edit),
                                  )
                                ],
                              ),
                              CustomTextFormField(
                                label: "Judul Agenda",
                                controller: controller.eventTitleController,
                                isPassword: false,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Judul agenda tidak boleh kosong';
                                  }
                                },
                              ),
                              CustomTextFormField(
                                label: "Deskripsi Agenda",
                                controller: controller.eventDescController,
                                isPassword: false,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Deskripsi agenda tidak boleh kosong';
                                  }
                                },
                              ),
                              CustomTextFormField(
                                label: "Tanggal Agenda",
                                controller: controller.selectedDateController,
                                isPassword: false,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Tanggal tidak boleh kosong';
                                  }
                                },
                              ),
                              CustomTextFormField(
                                label: "Waktu Agenda",
                                controller: controller.selectedTimeController,
                                isPassword: false,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Waktu Agenda tidak boleh kosong';
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),
                              Obx(() => ElevatedButton(
                                    onPressed: () {
                                      controller
                                          .updateEvent(
                                              event.id!, event.reminderTime)
                                          .then((value) {
                                        print("value update $value");
                                        if (value != 0) {
                                          Get.back();
                                        }
                                      });
                                    },
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          controller.loading.value
                                              ? CircularProgressIndicator(
                                                  color: Colors.white,
                                                )
                                              : Text(
                                                  "Save",
                                                )
                                        ],
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0XFF3B3C8C),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                onRefresh: () async {});
          }
        }));
  }
}
