// ignore: file_names
import 'dart:async';

import 'package:e_commerce/controllers/get-user-data-controller.dart';
import 'package:e_commerce/screens/admin-panel/admin-main-screen.dart';
import 'package:e_commerce/screens/auth-ui/welcomeScreen.dart';
import 'package:e_commerce/screens/user-panel/main-screen.dart';
import 'package:e_commerce/utils/appConstant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      chkiflog(context);
    });
  }

  Future<void> chkiflog(BuildContext context) async {
    if (user != null) {
      final GetUserDataCollection getUserDataCollection = Get.put(
        GetUserDataCollection(),
      );
      var userData = await getUserDataCollection.getUserData(user!.uid);
      if (userData[0]['isAdmin'] == true) {
        Get.offAll(()=> AdminMainScreen());
      }else{
        Get.offAll(()=> MainScreen());
      }
    } else {
      Get.offAll(() => WelcomeScreen());
    }
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
