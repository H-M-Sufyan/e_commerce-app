import 'package:e_commerce/controllers/forget-pass-controller.dart';
import 'package:e_commerce/utils/appConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final ForgetPassController forgetPassController = Get.put(
    ForgetPassController(),
  );
  TextEditingController userEmail = TextEditingController();
  bool obspass = true;
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppConstant.AppSecondColor,
            title: Text(
              "Forget Password",
              style: TextStyle(
                color: AppConstant.AppTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  isKeyboardVisible
                      ? Text("Welcome To Sufyan's Store!")
                      : Column(
                          children: [
                            Container(
                              color: AppConstant.AppSecondColor,
                              child: Lottie.asset(
                                'assets/images/ShoppingCartLoader.json',
                              ),
                            ),
                          ],
                        ),
                  SizedBox(height: Get.height / 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: userEmail,
                        cursorColor: AppConstant.AppSecondColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: Get.height / 20),
                  Material(
                    child: Container(
                      width: Get.width / 2,
                      height: Get.height / 18,
                      decoration: BoxDecoration(
                        color: AppConstant.AppSecondColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        child: Text(
                          "Forget Password",
                          style: TextStyle(color: AppConstant.AppTextColor),
                        ),
                        onPressed: () async {
                          String email = userEmail.text.trim();

                          if (email.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "Please Enter All Details",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.AppSecondColor,
                              colorText: AppConstant.AppTextColor,
                            );
                          } else {
                            forgetPassController.ForgetPassMethod(email);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
