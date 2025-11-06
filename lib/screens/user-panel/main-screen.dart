import 'package:e_commerce/screens/auth-ui/welcomeScreen.dart';
import 'package:e_commerce/utils/appConstant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.AppMainColor,
        title: Text(AppConstant.appMainName),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async {
              FirebaseAuth _auth = FirebaseAuth.instance;
              await _auth.signOut();
              Get.offAll(() => WelcomeScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
    );
  }
}
