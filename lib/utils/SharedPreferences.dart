import 'package:shared_preferences/shared_preferences.dart';

import 'Constants.dart';

class SharedPref {
  static SharedPreferences? _sharedPref;

  static Future init() async =>
      _sharedPref ??= await SharedPreferences.getInstance();

  static Future setEmail(String username) async =>
      await _sharedPref?.setString(usernameKey, username);
  String? getEmail() => _sharedPref?.getString(usernameKey);

  static Future setPassword(String password) async =>
      await _sharedPref?.setString(passwordKey, password);
  String? getPassword() => _sharedPref?.getString(passwordKey);

  static Future setIsRememberMe(bool isLogin) async =>
      await _sharedPref?.setBool(isRememberMeKey, isLogin);
  bool? getIsRememberMe() => _sharedPref?.getBool(isRememberMeKey) ?? false;

  static Future setAnswer(String answer) async =>
      await _sharedPref?.setString(answerKey, answer);
  String? getAnswer() => _sharedPref?.getString(answerKey);

}