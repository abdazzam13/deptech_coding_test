import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/SharedPreferences.dart';
import '../../controller/HomeController.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final HomeController homeController = Get.find();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset(
            "assets/logo.png",
            width: 70,
            height: 70,
          ),
          centerTitle: true,
        ),
        body: GetBuilder<HomeController>(builder: (controller) {
          if (controller.loading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else {
            return RefreshIndicator(
                child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(48), // Image radius
                                  child: controller.profilePicture != null
                                      ? Image.file(
                                    controller.profilePicture!,
                                    scale: 0.5,
                                    fit: BoxFit.cover,
                                  )
                                      : Image.asset(
                                      "assets/placeholder.png"),
                                ),
                              ),
                            ),

                            itemProfileDetail("Nama Depan", controller.firstName ?? "Abdullah"),
                            itemProfileDetail("Nama Belakang",controller.lastName ?? "Azzam"),
                            itemProfileDetail("Email",controller.email ?? "abdullah.azzam130@gmail.com"),
                            itemProfileDetail("Tanggal Lahir",controller.birthdate ?? "13 September 2000"),
                            itemProfileDetail("Jenis Kelamin",controller.gender ?? "Laki-laki"),
                            itemProfileDetail("Password", controller.password ??"hehehehehehehe"),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.editProfile);
                                },
                                child: Text("Edit Profile", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Color(0XFF3B3C8C),

                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.offNamed(AppRoutes.login);
                                },
                                child: Text("Logout", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.red,

                                ),
                              ),
                            ),

                          ],
                        ),
                      )
                    )),
                onRefresh: () async {});
          }
        }));
  }

  Widget itemProfileDetail(String title, String data){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title,style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16
        ),),
        Text(data),
      ],
    );
  }
}
