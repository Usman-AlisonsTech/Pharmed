import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pharmed_app/models/sent_otp_response_model.dart';
import 'package:pharmed_app/models/update_password_model.dart';
import 'package:pharmed_app/service/api_service.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/authentication/login/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpController extends GetxController {
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> updatePassword(String otp, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('loggedInToken') ?? '';
    if (newPass.text.isEmpty || confirmPass.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Password fields cannot be empty',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (newPass.text != confirmPass.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseurl}Auth/forgot_password/verifyCode'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        },
        body: jsonEncode({
          "email": email,
          "password": newPass.text,
          "c_password": confirmPass.text,
          "otp": otp, 
        }),
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        UpdatePasswordResponse updateResponse =
            UpdatePasswordResponse.fromJson(responseData);

        if (updateResponse.message == 'OTP Verified Succesfully.') {
  try {
    final confirmResponse = await ApiService()
        .confirmPassword(email, newPass.text, confirmPass.text);

    if (confirmResponse.success == true && confirmResponse.data == true) {
      Get.snackbar(
        'Success',
        confirmResponse.message ?? 'Your password is changed successfully.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAll(LoginView());
    } else {
      Get.snackbar(
        'Error',
        confirmResponse.message ?? 'Failed to change password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  } catch (e) {
    Get.snackbar(
      'Error',
      'Something went wrong while confirming password.',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    print('confirmPassword error: $e');
  }
}
 else {
          Get.snackbar(
            'Error',
            updateResponse.message ?? 'Failed to update password',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else if (response.statusCode == 404) {
        Get.snackbar(
          'Error',
          'Incorrect OTP',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Server error: ${response.statusCode}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update password. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error updating password: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('loggedInToken') ?? '';

    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseurl}${ApiConstants.forgotPass}'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        },
        body: jsonEncode({"email": email}),
      );

      print('Response Status Code : ${response.statusCode}');
      print('Response body : ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        SentOtpResponse sentOtpResponse =
            SentOtpResponse.fromJson(responseData);

        if (sentOtpResponse.success == true) {
          Get.snackbar(
            'Success',
            sentOtpResponse.message ?? 'OTP sent successfully!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Error',
            sentOtpResponse.message ?? 'Failed to send OTP',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Server error: ${response.statusCode}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send OTP. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error sending OTP: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
