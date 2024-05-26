import 'package:deptechcodingtest/view/component/customTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../routes/app_routes.dart';
import '../controller/CreateEventController.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final CreateEventController controller = Get.find();
  bool _reminderEnabled = false;
  String _selectedReminder = "3 hari sebelum";
  final List<String> _reminderOptions = [
    "3 hari sebelum",
    "1 hari sebelum",
    "1 jam sebelum"
  ];

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
      body: GetBuilder<CreateEventController>(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildSectionTitle("Judul Agenda"),
                            CustomTextFormField(
                              label: "Judul Agenda",
                              controller: controller.eventTitleController,
                              isPassword: false,
                              validator: (value){
                                if (value == null){
                                  return 'Judul agenda tidak boleh kosong';
                                }
                              },
                            ),
                            _buildSectionTitle("Deskripsi Agenda"),
                            CustomTextFormField(
                              label: "Deskripsi Agenda",
                              controller: controller.eventDescController,
                              isPassword: false,
                              validator: (value){
                                if (value == null){
                                  return 'Deskripsi agenda tidak boleh kosong';
                                }
                              },
                            ),
                            _buildSectionTitle("Pilih Tanggal Agenda"),
                            SizedBox(height: 10),
                            _buildDatePicker(context),
                            SizedBox(height: 10),
                            _buildSectionTitle("Pilih Waktu Agenda"),
                            _buildTimePicker(context),
                            SizedBox(height: 10),
                            _buildSectionTitle("Nyalakan Pengingat?"),
                            _buildReminderSection(),
                            SizedBox(height: 10),
                            _buildSectionTitle("Lampiran"),
                            _buildAttachmentOptions(),
                            if (controller.picture != null)
                              Image.file(
                                controller.picture!,
                                scale: 0.5,
                                fit: BoxFit.cover,
                              ),
                            SizedBox(height: 10),
                            Obx(() => ElevatedButton(
                              onPressed: () {
                                Get.offNamed(AppRoutes.home);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  controller.loading.value
                                      ? CircularProgressIndicator(color: Colors.white)
                                      : Text("Log in"),
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17,
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.calendar_month_sharp),
            SizedBox(width: 10),
            Text(
              "${controller.selectedDate.day} ${controller.getMonth(controller.selectedDate.month)} ${controller.selectedDate.year}",
            ),
            Spacer(),
            InkWell(
              onTap: () {
                setState(() {
                  controller.isEditDate = !controller.isEditDate;
                });
              },
              child: Icon(Icons.edit),
            ),
          ],
        ),
        if (controller.isEditDate)
          CalendarDatePicker(
            initialDate: controller.selectedDate,
            firstDate: controller.firstDate,
            lastDate: controller.lastDate,
            onDateChanged: (newDate) {
              setState(() {
                controller.selectedDate = newDate;
              });
            },
          ),
      ],
    );
  }

  Widget _buildTimePicker(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            controller.selectTime(context);
          },
          child: Icon(Icons.access_time),
        ),
        SizedBox(width: 10),
        Text("${controller.selectedTime.hour} : ${controller.selectedTime.minute} WIB"),
        Spacer(),
        InkWell(
          onTap: () {
            controller.selectTime(context);
          },
          child: Icon(Icons.edit),
        ),
      ],
    );
  }

  Widget _buildReminderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: Text("Aktifkan Pengingat"),
          value: _reminderEnabled,
          onChanged: (bool value) {
            setState(() {
              _reminderEnabled = value;
            });
          },
        ),
        if (_reminderEnabled)
          Container(
            margin: EdgeInsets.only(left: 20),
            child: DropdownButton<String>(
              value: _selectedReminder,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedReminder = newValue!;
                });
              },
              items: _reminderOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          )
      ],
    );
  }

  Widget _buildAttachmentOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            controller.takePictureWithCamera();
          },
          child: Text("Camera"),
        ),
        ElevatedButton(
          onPressed: () {
            controller.pickImageFromGallery();
          },
          child: Text("Gallery"),
        ),
      ],
    );
  }
}
