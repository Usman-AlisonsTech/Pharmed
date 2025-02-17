import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/models/login_response_model.dart';
import 'package:pharmed_app/service/api_service.dart';
import 'package:pharmed_app/views/authentication/login/login_otp/login_otp_view.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;

  final emailformKey = GlobalKey<FormState>();
  final passformKey = GlobalKey<FormState>();

  final ApiService apiService = ApiService();

  Future<void> login() async {
    // Validate form
    if (!emailformKey.currentState!.validate() ||
        !passformKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;
      LoginResponse? loginResponse =
          await apiService.login(emailController.text, passwordController.text);

      if (loginResponse != null && loginResponse.success == true) {
        Get.offAll(LoginOtpView(email: emailController.text));
      } else {
        Get.snackbar("Error", loginResponse?.message ?? "Login failed",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error",
          "UnAuthorized User, Please Check Password or create a new account",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
