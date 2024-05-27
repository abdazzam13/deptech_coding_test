import 'package:shared_preferences/shared_preferences.dart';
import 'Constants.dart';

class SharedPref {
  static SharedPreferences? _sharedPref;

  static Future init() async =>
      _sharedPref ??= await SharedPreferences.getInstance();

  static Future setEmail(String email) async =>
      await _sharedPref?.setString(emailKey, email);

  String? getEmail() => _sharedPref?.getString(emailKey);

  static Future setPassword(String password) async =>
      await _sharedPref?.setString(passwordKey, password);

  String? getPassword() => _sharedPref?.getString(passwordKey);

  static Future setIsLogin(bool isLogin) async =>
      await _sharedPref?.setBool(isLoginKey, isLogin);

  bool? getIsLogin() => _sharedPref?.getBool(isLoginKey) ?? false;
}
