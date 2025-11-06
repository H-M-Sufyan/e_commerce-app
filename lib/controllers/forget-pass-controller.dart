import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/screens/auth-ui/signin.dart';
import 'package:e_commerce/utils/appConstant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ForgetPassController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  Future<void> ForgetPassMethod(
    String usreEmail,
  ) async {
    try {
      EasyLoading.show(status: "please Wait");
      await _auth.sendPasswordResetEmail(email: usreEmail);
      Get.snackbar(
        "Request Sent Successfully!",
        "Password reset link sent to $usreEmail",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.AppSecondColor,
        colorText: AppConstant.AppTextColor,
      );

      Get.offAll(()=> SignInScreen());

      EasyLoading.dismiss();

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
