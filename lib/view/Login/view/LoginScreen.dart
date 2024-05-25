import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../controller/LoginController.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.find();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: GetBuilder<LoginController>(builder: (controller) {
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
                        padding: EdgeInsets.fromLTRB(20, 60, 0, 10),
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                        child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  floatingLabelStyle:
                                  TextStyle(color: Colors.lightBlueAccent),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.lightBlueAccent)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                controller: emailController,
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                obscureText: controller.isObscureText,
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    floatingLabelStyle:
                                    TextStyle(color: Colors.lightBlueAccent),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.lightBlueAccent)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    suffixIcon: InkWell(
                                      child: Icon(Icons.remove_red_eye),
                                      onTap: () {
                                        setState(() {
                                          controller.isObscureText = !controller.isObscureText;
                                        });
                                      },
                                    )),
                                controller: passwordController,
                              ),
                              SizedBox(height: 20.0),
                              Obx(() => ElevatedButton(
                                onPressed: () {
                                        Get.offNamed(AppRoutes.home);
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      controller.loading.value ? CircularProgressIndicator(color: Colors.white,) : Text(
                                        "Log in",
                                      )
                                    ],
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0XFF3B3C8C),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5))),
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
              onRefresh: () async {

              });
        }
      })
    );
  }
}
