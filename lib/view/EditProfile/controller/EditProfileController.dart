import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import '../../../data/local/database/userDatabase.dart';
import '../../../data/local/model/user.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/SharedPreferences.dart';
import '../../component/customSnackbar.dart';

class EditProfileController extends GetxController {
  var loading = false.obs;
  var isObscureText = true;
  ImagePicker picker = ImagePicker();
  late User? user;
  File? profilePicture;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getUserFromDb();
  }
  Future pickImageFromGallery() async {
    try {
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      profilePicture = imageTemporary;
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
      profilePicture = imageTemporary;
      print("profilePicture $profilePicture");
      update();
    } on PlatformException catch (e) {
      print('gagal mengambil gambar dari galeri $e');
    }
  }


  Future<User?> getUserFromDb() async {
    print("masuk get from db in controller");
    final openDb = await openDatabase(UserDatabase.TABLE_NAME);
    final db = UserDatabase(openDb);
    var user = db.getUserByEmail(SharedPref().getEmail()!);

    user.then((value){
      if (value != null){
        emailController.text = value!.email!;
        passwordController.text = value.password!;
        firstNameController.text = value.firstName!;
        lastNameController.text = value.lastName!;
        birthdateController.text = value.birthdate!;
        genderController.text = value.gender!;
        profilePicture = value.profilePic != null ? File(value.profilePic!)  : null;
        update();
      }
    });
    return user;
  }

  Future<int> updateUserByEmail() async {
    final openDb = await openDatabase(UserDatabase.TABLE_NAME);
    final db = UserDatabase(openDb);
    final count = db.updateUserByEmail(SharedPref().getEmail()!, User(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      birthdate: birthdateController.text,
      gender: genderController.text,
      password: passwordController.text,
      profilePic: profilePicture?.path,
    ));
    return count;
  }


}