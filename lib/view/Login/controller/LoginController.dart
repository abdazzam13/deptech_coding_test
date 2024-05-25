import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/SharedPreferences.dart';
import '../../component/customSnackbar.dart';

class LoginController extends GetxController {
  var loading = false.obs;
  var isInternetConnected = false.obs;
  var isObscureText = true;
  var checkedValue = false;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  // Future<void> login(BuildContext context, String username, String password) async{
  //   loading.value = true;
  //   if (res?.message == "success"){
  //
  //     SharedPref.setUsername(username);
  //     SharedPref.setPassword(password);
  //     SharedPref.setIsRememberMe(false);
  //     Get.offNamed(AppRoutes.home);
  //   } else {
  //     loading.value = false;
  //     CustomSnackBar.show(context, "User not found", false);
  //   }
  // }
  // Future<void> loginRememberMe(BuildContext context, String username, String password) async{
  //   loading.value = true;
  //   var res = await repository.login(username, password);
  //   if (res?.message == "success"){
  //     loading.value = false;
  //     SharedPref.setUsername(username);
  //     SharedPref.setPassword(password);
  //     SharedPref.setIsRememberMe(true);
  //     Get.offNamed(AppRoutes.home);
  //   } else {
  //     loading.value = false;
  //     CustomSnackBar.show(context, "User not found", false);
  //   }
  // }


}