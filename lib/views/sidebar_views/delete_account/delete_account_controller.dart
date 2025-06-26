import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/service/api_service.dart';
import 'package:pharmed_app/views/authentication/login/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccountController extends GetxController {
  RxBool isLoading = false.obs;
  final ApiService apiService = ApiService();

    Future<void> deleteAccount() async {
    try {
      final response =  await apiService.deleteAccount();

      if (response['message'].toString() == 'OTP Sent Successfully') {
       Get.snackbar("Success", '${response['message']??'Otp Sent'}',
            backgroundColor: Colors.green, colorText: Colors.white);
      }
       else {
        Get.snackbar("Error", '${response['message']??'Error'}',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error",
          "Error,Otp not sent",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> delAccVerifyOtp(String otp) async {
    isLoading.value = true;
    try {
      final response =  await apiService.delAccOtpVerify(otp);

      if (response['message'].toString() == 'User Soft Deleted Successfully.') {
       Get.snackbar("Success", '${response['message']??'Otp Sent'}',
            backgroundColor: Colors.green, colorText: Colors.white);

        SharedPreferences prefs =await SharedPreferences.getInstance();    
        await prefs.remove('loggedInToken'); 
        Get.offAll(LoginView());
      }
       else {
        Get.snackbar("Error", '${response['message']??'Error'}',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error",
          "Account Not Deleted.",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}