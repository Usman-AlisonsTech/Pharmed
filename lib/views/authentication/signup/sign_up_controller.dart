import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/models/signup_response_model.dart';
import 'package:pharmed_app/service/api_service.dart';
import 'package:pharmed_app/views/authentication/login/login_view.dart';
import 'package:pharmed_app/views/authentication/signup/signup_otp/signup_otp_view.dart';

class SignUpController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordObscured = true;
  Icon eyeIcon = const Icon(
    Icons.remove_red_eye,
    size: 20,
  );
  bool isChecked = false;
  bool showSuffixIcon = false;
  RxBool isLoading = false.obs;
  final apiService = ApiService();

  final emailformKey = GlobalKey<FormState>();
  final firstName = GlobalKey<FormState>();
  final lastName = GlobalKey<FormState>();
  final phoneNumformKey = GlobalKey<FormState>();
  final passformKey = GlobalKey<FormState>();

 signUp() async {
  if (!firstName.currentState!.validate() ||
      !lastName.currentState!.validate() ||
      !emailformKey.currentState!.validate() ||
      !passformKey.currentState!.validate()) {
    return;
  }

  try {
    isLoading.value = true;

    var response = await apiService.signUp(
      firstNameController.text+lastNameController.text,
      emailController.text,
      phoneNumController.text,
      passwordController.text,
    );

    if (response is SignUpResponse) {
      // Extract message from model when status is 201
      final message = response.data?.issue.isNotEmpty == true
          ? response.data?.issue.first.details?.text ?? "Success"
          : "User created successfully.";

      Get.snackbar("Success", message,
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.to(SignupOtpView(email: emailController.text));

    } else if (response is String) {
      // For other cases, use plain string message
      if (response.toLowerCase().contains("user already exists")) {
        Get.snackbar("Error", response,
            backgroundColor: Colors.red, colorText: Colors.white);
        Get.offAll(LoginView());
      } else if (response.toLowerCase().contains("not verified")) {
        Get.snackbar("Notice", response,
            backgroundColor: Colors.orange, colorText: Colors.white);
        Get.to(SignupOtpView(email: emailController.text));
      } else {
        Get.snackbar("Error", response,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  } catch (e) {
    print("Sign up error: $e");
    Get.snackbar("Error", "An error occurred. Please try again.",
        backgroundColor: Colors.red, colorText: Colors.white);
  } finally {
    isLoading.value = false;
  }
}
}