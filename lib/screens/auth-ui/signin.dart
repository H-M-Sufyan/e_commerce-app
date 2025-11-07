import 'package:e_commerce/controllers/get-user-data-controller.dart';
import 'package:e_commerce/controllers/signin-controller.dart';
import 'package:e_commerce/screens/admin-panel/admin-main-screen.dart';
import 'package:e_commerce/screens/auth-ui/signup.dart';
import 'package:e_commerce/screens/forget-pass-screen.dart';
import 'package:e_commerce/screens/user-panel/main-screen.dart';
import 'package:e_commerce/utils/appConstant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignIncontroller signIncontroller = Get.put(SignIncontroller());
  final GetUserDataCollection getUserDataCollection = Get.put(
    GetUserDataCollection(),
  );
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
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
              "Sign In",
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

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: userPassword,
                        cursorColor: AppConstant.AppSecondColor,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obspass,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obspass ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                obspass = !obspass;
                              });
                            },
                          ),
                          contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => ForgetPassScreen());
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: AppConstant.AppSecondColor,
                          fontWeight: FontWeight.bold,
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
                          "SIGN IN",
                          style: TextStyle(color: AppConstant.AppTextColor),
                        ),
                        onPressed: () async {
                          String email = userEmail.text.trim();
                          String password = userPassword.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "Please Enter All Details",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.AppSecondColor,
                              colorText: AppConstant.AppTextColor,
                            );
                            return;
                          }

                          UserCredential? userCredential =
                              await signIncontroller.SignInMethod(
                                email,
                                password,
                              );

                          if (userCredential == null) {
                            Get.snackbar(
                              "Error",
                              "Login Failed",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            return;
                          }

                          if (!userCredential.user!.emailVerified) {
                            Get.snackbar(
                              "Email Not Verified",
                              "Please verify your email before login.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.AppSecondColor,
                              colorText: AppConstant.AppTextColor,
                            );
                            return;
                          }

                          var userData = await getUserDataCollection
                              .getUserData(userCredential.user!.uid);

                          if (userData[0]['isAdmin'] == true) {
                            Get.offAll(() => AdminMainScreen());

                          } else {
                            Get.offAll(() => MainScreen());
                          }

                          Get.snackbar(
                            "Success",
                            "Login Successfully!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.AppSecondColor,
                            colorText: AppConstant.AppTextColor,
                          );
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: Get.height / 50),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Have an Account?",
                        style: TextStyle(color: AppConstant.AppSecondColor),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => Get.offAll(() => SignUp()),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: AppConstant.AppSecondColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
