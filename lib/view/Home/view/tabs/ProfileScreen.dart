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
  ImagePicker picker = ImagePicker();
  File? profilePicture;

  Future pickImageFromGallery() async {
    try {
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        profilePicture = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('gagal mengambil gambar dari galeri $e');
    }
  }

  Future takePictureWithCamera() async {
    try {
      final image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        profilePicture = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('gagal mengambil gambar dari galeri $e');
    }
  }
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
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(48), // Image radius
                                    child: profilePicture != null
                                        ? Image.file(
                                      profilePicture!,
                                      scale: 0.5,
                                      fit: BoxFit.cover,
                                    )
                                        : Image.asset(
                                        "assets/placeholder.png"),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () async {
                                    bool? isCamera = await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                takePictureWithCamera();
                                                Navigator.pop(context);
                                              },
                                              child: Text("Camera"),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                pickImageFromGallery();
                                                Navigator.pop(context);
                                              },
                                              child: Text("Gallery"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                    isCamera!
                                        ? takePictureWithCamera()
                                        : pickImageFromGallery();
                                  },
                                  child: Icon(Icons.edit),
                                )
                              ],
                            ),

                            Text("Nama Depan: Abdullah"),
                            Text("Nama Belakang: Azzam"),
                            Text(
                              "Email: ${SharedPref().getEmail() ?? "email.com"}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text("Tanggal Lahir: 13 September 2000"),
                            Text("Jenis Kelamin: Laki-laki"),
                            Text("Password: Abdullah"),

                            ElevatedButton(
                              onPressed: () {
                                Get.offNamed(AppRoutes.login);
                              },
                              child: Text("Logout"),
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.red),
                            )
                          ],
                        ),
                      ),
                    )),
                onRefresh: () async {});
          }
        }));
  }
}
