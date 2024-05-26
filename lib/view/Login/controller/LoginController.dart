import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../data/local/database/userDatabase.dart';
import '../../../data/local/model/user.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/SharedPreferences.dart';
import '../../component/customSnackbar.dart';
import 'package:sqflite/sqflite.dart';
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

  Future<void> login(BuildContext context, String email, String password) async{
    loading.value = true;
    getUserFromDb(email).then((value){
      print("user ${value}");
      if (value != null){
        if (value.email == email && value.password == password){
          loading.value = false;
          SharedPref.setEmail(email);
          SharedPref.setPassword(password);
          SharedPref.setIsRememberMe(true);
          Get.offNamed(AppRoutes.home);
        }
       if (value.email != email){
         loading.value = false;
         CustomSnackBar.show(context, "Email yang Anda ketikkan salah", false);
       }
       if (value.password != password){
         loading.value = false;
         CustomSnackBar.show(context, "Password yang Anda ketikkan salah", false);
       }
      } else {
        loading.value = false;
        CustomSnackBar.show(context, "User not found", false);
      }
    });

  }

  Future<User?> getUserFromDb(String email) async {
    print("masuk get from db in controller");
    final openDb = await openDatabase(UserDatabase.TABLE_NAME);
    final db = UserDatabase(openDb);
    var user = db.getUserByEmail(email);
    return user;
  }


}