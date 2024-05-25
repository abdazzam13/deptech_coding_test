import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/SharedPreferences.dart';
import '../../component/customSnackbar.dart';

class HomeController extends GetxController {
  var loading = false.obs;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

}
