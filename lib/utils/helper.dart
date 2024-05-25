import 'dart:convert';
import 'package:get/get.dart';
import 'Constants.dart';
import 'SharedPreferences.dart';

class Helper {
  String capitalizeFirstLetter(String input) {
    List<String> words = input.split(" ");
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }
    return words.join(" ");
  }
  String cutString(String string) {
    if (string.length > 30) {
      return string.substring(0, 30) + "...";
    } else {
      return string;
    }
  }

}