import 'dart:async';
import 'package:deptechcodingtest/data/local/database/userDatabase.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../../../data/local/model/user.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/SharedPreferences.dart';

class SplashController extends GetxController {

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    timer();
    getUserFromDb("candidate@deptechdigital.com").then((value){
      if (value == null){
        insertUserToDb();
      }
    });
    print("isLogin ${SharedPref().getIsRememberMe()}");
  }

  void timer() {
    var timer = const Duration(seconds: 4);
    Timer(timer, () {
      if (SharedPref().getIsRememberMe() == true) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    });
  }

  Future<int> insertUserToDb() async {
    print("masuk insert to db in controller");
    final openDb = await openDatabase(UserDatabase.TABLE_NAME);
    final db = UserDatabase(openDb);
    var id = db.insertUser(User(
        firstName: "Abdullah",
        lastName: "Azzam",
        email: "candidate@deptechdigital.com",
        birthdate: "13 September 2000",
        gender:"Laki-laki",
        password: "testInterview123!",
        profilePic: null
    ));
    return id;
  }

  Future<User?> getUserFromDb(String email) async {
    print("masuk get from db in controller");
    final openDb = await openDatabase(UserDatabase.TABLE_NAME);
    final db = UserDatabase(openDb);
    var user = db.getUserByEmail(email);
    return user;
  }

}