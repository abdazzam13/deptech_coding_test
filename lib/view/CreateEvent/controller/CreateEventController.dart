import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/SharedPreferences.dart';
import '../../component/customSnackbar.dart';

class CreateEventController extends GetxController {
  var loading = false.obs;
  var isInternetConnected = false.obs;
  var isObscureText = true;
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController eventDescController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  //select dates
  DateTime selectedDate = DateTime.now();
  final firstDate = DateTime.now();
  final lastDate = DateTime(2050, 12);
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

}