import 'package:deptechcodingtest/view/CreateEvent/binding/CreateEventBinding.dart';
import 'package:deptechcodingtest/view/CreateEvent/view/CreateEventScreen.dart';
import 'package:deptechcodingtest/view/EditProfile/binding/EditProfileBinding.dart';
import 'package:deptechcodingtest/view/EditProfile/view/EditProfileScreen.dart';
import 'package:get/get.dart';
import '../view/Home/binding/homeBinding.dart';
import '../view/Home/view/HomeScreen.dart';
import '../view/Login/binding/loginBinding.dart';
import '../view/Login/view/LoginScreen.dart';
import '../view/SplashScreen/binding/splashBinding.dart';
import '../view/SplashScreen/view/SplashScreen.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
        name: AppRoutes.splashscreen,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: AppRoutes.login,
        page: () => LoginScreen(),
        binding: LoginBinding()),
    GetPage(
        name: AppRoutes.home,
        page: () => HomeScreen(),
        binding: HomeBinding()),
    GetPage(
        name: AppRoutes.editProfile,
        page: () => EditProfileScreen(),
        binding: EditProfileBinding()),
    GetPage(
        name: AppRoutes.createEvent,
        page: () => CreateEventScreen(),
        binding: CreateEventBinding()),

  ];
}
