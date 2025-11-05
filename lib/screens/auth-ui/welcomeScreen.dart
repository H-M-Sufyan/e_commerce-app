import 'package:e_commerce/controllers/google-sign-in-controller.dart';
import 'package:e_commerce/screens/auth-ui/signin.dart';
import 'package:e_commerce/utils/appConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final GoogleSignInController _googleSignInController = Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.AppMainColor,
        title: Text(
          "Welcome To Sufyan's Store",
          style: TextStyle(color: AppConstant.AppTextColor),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: AppConstant.AppMainColor,
              child: Lottie.asset('assets/images/ShoppingCartLoader.json'),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                "Happy Shopping",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: Get.height / 12),
            Material(
              child: Container(
                width: Get.width / 1.2,
                height: Get.height / 12,
                decoration: BoxDecoration(
                  color: AppConstant.AppSecondColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton.icon(
                  icon: Image.asset(
                    'assets/images/googleicon.png',
                    width: Get.width / 14,
                    height: Get.width / 15,
                  ),
                  label: Text(
                    "Sign in With google",
                    style: TextStyle(color: AppConstant.AppTextColor),
                  ),
                  onPressed: () {
                    _googleSignInController.SignInWithGoogle();
                  },
                ),
              ),
            ),
            SizedBox(height: Get.height / 50),
            Material(
              child: Container(
                width: Get.width / 1.2,
                height: Get.height / 12,
                decoration: BoxDecoration(
                  color: AppConstant.AppSecondColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton.icon(
                  icon: Icon(Icons.email, color: AppConstant.AppTextColor, size: 30,),
                  label: Text(
                    "Sign in With Email",
                    style: TextStyle(color: AppConstant.AppTextColor),
                  ),
                  onPressed: () {
                    Get.to(()=> SignInScreen());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
