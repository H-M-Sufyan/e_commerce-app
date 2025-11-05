import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/utils/appConstant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SignIncontroller extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // for password visible
  var ispasswordVisible = false.obs;

  Future<UserCredential?> SignInMethod(
    String usreEmail,
    String userPassword,
  ) async {
    try {
      EasyLoading.show(status: "please Wait");
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(
            email: usreEmail,
            password: userPassword,
          );


      EasyLoading.dismiss();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        "Error",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.AppSecondColor,
        colorText: AppConstant.AppTextColor,
      );
    }
  }
}
