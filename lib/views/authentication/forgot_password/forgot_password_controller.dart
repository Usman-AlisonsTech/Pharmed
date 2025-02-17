import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pharmed_app/models/sent_otp_response_model.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/authentication/forgot_password/otp_screen/otp_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  var isLoading = false.obs;

  Future<void> sendOtp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('loggedInToken') ?? '';
    if (emailController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Email field cannot be empty',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse(
            '${ApiConstants.baseurl}${ApiConstants.forgotPass}'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        },
        body: jsonEncode({"email": emailController.text}),
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
          Get.to(OtpView(email: emailController.text,));
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
