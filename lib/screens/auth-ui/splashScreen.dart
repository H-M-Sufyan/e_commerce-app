// ignore: file_names
import 'dart:async';

import 'package:e_commerce/screens/auth-ui/welcomeScreen.dart';
import 'package:e_commerce/utils/appConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Get.offAll(() => WelcomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.AppSecondColor,
      appBar: AppBar(backgroundColor: AppConstant.AppSecondColor, elevation: 0),

      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                alignment: Alignment.center,
                child: Lottie.asset('assets/images/shoppingcart.json'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              width: Get.width,
              alignment: Alignment.center,
              child: Text(
                AppConstant.appPoweredBy,
                style: TextStyle(
                  color: AppConstant.AppTextColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
