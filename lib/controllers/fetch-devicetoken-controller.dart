import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../utils/appConstant.dart';

class FetchDeviceToken extends GetxController{
  String? deviceToken;

  @override 
  void onInit(){
    super.onInit();
    getDeviceToken();
  }

  Future<void> getDeviceToken() async{
    try {
      String? token = await FirebaseMessaging.instance.getToken();

      if (token != null) {
        deviceToken = token;
        print("Device Token $deviceToken");
        update();
      }
    } catch (e) {
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