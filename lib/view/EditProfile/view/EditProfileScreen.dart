import 'package:deptechcodingtest/view/component/customTextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../controller/EditProfileController.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final EditProfileController controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset(
            "assets/logo.png",
            width: 70,
            height: 70,
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: GetBuilder<EditProfileController>(builder: (controller) {
          if (controller.loading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.lightBlueAccent,
              ),
            );
          } else {
            return RefreshIndicator(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipOval(
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
                                                  controller
                                                      .takePictureWithCamera();
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Camera"),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  controller
                                                      .pickImageFromGallery();
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Gallery"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                      isCamera!
                                          ? controller.takePictureWithCamera()
                                          : controller.pickImageFromGallery();
                                    },
                                    child: Icon(Icons.edit),
                                  )
                                ],
                              ),
                              CustomTextFormField(
                                label: "Nama Depan",
                                controller: controller.firstNameController,
                                isPassword: false,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Nama Depan tidak boleh kosong';
                                  }
                                },
                              ),
                              CustomTextFormField(
                                label: "Nama Belakang",
                                controller: controller.lastNameController,
                                isPassword: false,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Nama belakang tidak boleh kosong';
                                  }
                                },
                              ),
                              CustomTextFormField(
                                label: "Email",
                                controller: controller.emailController,
                                isPassword: false,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Email tidak boleh kosong';
                                  } else if (!RegExp(
                                          r"[a-zA-Z0-9.+_-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
                                      .hasMatch(value)) {
                                    return 'Format email tidak valid';
                                  }
                                },
                              ),
                              CustomTextFormField(
                                label: "Tanggal Lahir",
                                controller: controller.birthdateController,
                                isPassword: false,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Tanggal lahir tidak boleh kosong';
                                  }
                                },
                              ),
                              CustomTextFormField(
                                label: "Jenis Kelamin",
                                controller: controller.genderController,
                                isPassword: false,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Jenis kelamin tidak boleh kosong';
                                  }
                                },
                              ),
                              CustomTextFormField(
                                label: "Password",
                                controller: controller.passwordController,
                                isPassword: true,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Password tidak boleh kosong';
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),
                              Obx(() => ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        controller
                                            .updateUserByEmail()
                                            .then((value) {
                                          print("value update $value");
                                          if (value != 0) {
                                            Get.offAllNamed(AppRoutes.home);
                                          }
                                        });
                                      }
                                    },
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          controller.loading.value
                                              ? CircularProgressIndicator(
                                                  color: Colors.white,
                                                )
                                              : Text(
                                                  "Save",
                                                )
                                        ],
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0XFF3B3C8C),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                onRefresh: () async {});
          }
        }));
  }
}
