import 'dart:math';
import 'package:deptechcodingtest/utils/notificationService.dart';
import 'package:deptechcodingtest/view/component/customDatePicker.dart';
import 'package:deptechcodingtest/view/component/customSetReminder.dart';
import 'package:deptechcodingtest/view/component/customTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../component/customTimePicker.dart';
import '../../component/customUploadImage.dart';
import '../../component/sectionTitle.dart';
import '../controller/EventController.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final EventController controller = Get.find();
  final _formKey = GlobalKey<FormState>();

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
      body: GetBuilder<EventController>(
        builder: (controller) {
          if (controller.loading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.lightBlueAccent,
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {},
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            sectionTitle(title: "Judul Agenda"),
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
                            sectionTitle(title: "Deskripsi Agenda"),
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
                            sectionTitle(title: "Pilih Tanggal Agenda"),
                            SizedBox(height: 10),
                            customDatePicker(
                              controller: controller,
                            ),
                            SizedBox(height: 10),
                            sectionTitle(title: "Pilih Waktu Agenda"),
                            customTimePicker(
                                controller: controller, context: context),
                            SizedBox(height: 10),
                            sectionTitle(title: "Nyalakan Pengingat?"),
                            customSetReminder(controller: controller),
                            SizedBox(height: 10),
                            sectionTitle(title: "Lampiran"),
                            customUploadImage(controller: controller),
                            if (controller.picture != null)
                              Image.file(
                                controller.picture!,
                                scale: 0.5,
                                fit: BoxFit.cover,
                              ),
                            SizedBox(height: 10),
                            Obx(() => ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      controller.insertEvent().then((value) {
                                        if (value != 0) {
                                          Get.offAllNamed(AppRoutes.home);
                                        }
                                      });
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      controller.loading.value
                                          ? CircularProgressIndicator(
                                              color: Colors.white)
                                          : Text("Save"),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0XFF3B3C8C),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
