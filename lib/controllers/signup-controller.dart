import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/user-model.dart';
import 'package:e_commerce/utils/appConstant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SignUpcontroller extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // for password visible
  var ispasswordVisible = false.obs;

  Future<UserCredential?> SignUpMethod(
    String userName,
    String usreEmail,
    String userPhone,
    String userCity,
    String userPassword,
    String userDeviceToken,
  ) async {
    try {
      EasyLoading.show(status: "please Wait");
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: usreEmail,
            password: userPassword,
          );

      await userCredential.user!.sendEmailVerification();

      UserModel userModel = UserModel(
        uId: userCredential.user!.uid,
        username: userName,
        email: usreEmail,
        phone: userPhone,
        userImg: '',
        userDeviceToken: userDeviceToken,
        country: '',
        userAddress: '',
        street: '',
        isAdmin: false,
        isActive: true,
        createOn: DateTime.now(),
        city: userCity,
      );

      // add data into database
      _firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());

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
