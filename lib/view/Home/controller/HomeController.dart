import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../../../data/local/database/eventDatabase.dart';
import '../../../data/local/database/userDatabase.dart';
import '../../../data/local/model/event.dart';
import '../../../data/local/model/user.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/SharedPreferences.dart';
import '../../component/customSnackbar.dart';

class HomeController extends GetxController {
  var loading = false.obs;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? birthdate;
  String? gender;
  File? profilePicture;
  List<Event>? events = [];

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getUserFromDb();
    getEventFromDb();
  }

  Future<User?> getUserFromDb() async {
    print("masuk get from db in controller");
    final openDb = await openDatabase(UserDatabase.TABLE_NAME);
    final db = UserDatabase(openDb);
    var user = db.getUserByEmail(SharedPref().getEmail()!);

    user.then((value) {
      if (value != null) {
        email = value!.email!;
        password = value.password!;
        firstName = value.firstName!;
        lastName = value.lastName!;
        birthdate = value.birthdate!;
        gender = value.gender!;
        profilePicture =
            value.profilePic != null ? File(value.profilePic!) : null;
        update();
      }
    });
    return user;
  }

  Future<List<Event>?> getEventFromDb() async {
    loading.value = true;
    final openDb = await openDatabase(EventDatabase.TABLE_NAME);
    final db = EventDatabase(openDb);
    var events = db.getEvents();
    loading.value = false;
    return events;
  }
}
