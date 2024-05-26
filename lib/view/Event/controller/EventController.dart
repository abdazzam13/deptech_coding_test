import 'dart:async';
import 'dart:io';
import 'package:deptechcodingtest/data/local/database/eventDatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import '../../../data/local/database/userDatabase.dart';
import '../../../data/local/model/event.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/SharedPreferences.dart';
import '../../component/customSnackbar.dart';

class EventController extends GetxController {
  var loading = false.obs;
  var isInternetConnected = false.obs;
  var isObscureText = true;

  TextEditingController eventTitleController = TextEditingController();
  TextEditingController eventDescController = TextEditingController();
  TextEditingController selectedDateController = TextEditingController();
  TextEditingController selectedTimeController = TextEditingController();

  //select dates
  DateTime selectedDate = DateTime.now();
  final firstDate = DateTime.now();
  final lastDate = DateTime(2050, 12);

  String selectedReminder = "3 hari sebelum";
  final List<String> reminderOptions = [
    "3 hari sebelum",
    "1 hari sebelum",
    "1 jam sebelum"
  ];

  String getMonth(int currentMonthIndex) {
    List month = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return month[currentMonthIndex - 1];
  }

  var isEditDate = false;

  //select time
  TimeOfDay selectedTime = TimeOfDay.now();

  //select pict
  ImagePicker picker = ImagePicker();
  File? picture;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (newTime != null) {
      selectedTime = newTime;
      update();
    }
  }

  Future pickImageFromGallery() async {
    try {
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      picture = imageTemporary;
      update();
    } on PlatformException catch (e) {
      print('gagal mengambil gambar dari galeri $e');
    }
  }

  Future takePictureWithCamera() async {
    try {
      final image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      picture = imageTemporary;
      update();
    } on PlatformException catch (e) {
      print('gagal mengambil gambar dari galeri $e');
    }
  }

  Future<int> insertEvent() async {
    print("masuk insert to db in controller");
    final openDb = await openDatabase(EventDatabase.TABLE_NAME);
    final db = EventDatabase(openDb);
    var id = db.insertEvent(Event(
        title: eventTitleController.text,
        desc: eventDescController.text,
        date:
            "${selectedDate.day} ${getMonth(selectedDate.month)} ${selectedDate.year}",
        time: "${selectedTime.hour} : ${selectedTime.minute} WIB",
        reminderTime: selectedReminder,
        pic: picture != null ? picture!.path : null));
    return id;
  }

  Future<int> updateEvent(int id, String? reminder) async {
    final openDb = await openDatabase(EventDatabase.TABLE_NAME);
    final db = EventDatabase(openDb);
    final count = db.updateEvents(
        id,
        Event(
          id: id,
            title: eventTitleController.text,
            desc: eventDescController.text,
            date: selectedDateController.text,
            time: selectedTimeController.text,
            reminderTime: reminder,
            pic: picture?.path));
    return count;
  }
}
