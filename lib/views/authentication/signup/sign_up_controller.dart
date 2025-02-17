import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/models/signup_error_response_model.dart';
import 'package:pharmed_app/models/signup_response_model.dart';
import 'package:pharmed_app/service/api_service.dart';
import 'package:pharmed_app/views/authentication/login/login_view.dart';
import 'package:pharmed_app/views/authentication/signup/signup_otp/signup_otp_view.dart';

class SignUpController extends GetxController {
  TextEditingController userNameController = TextEditingController();
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
  final userNameformKey = GlobalKey<FormState>();
  final phoneNumformKey = GlobalKey<FormState>();
  final passformKey = GlobalKey<FormState>();

  signUp() async {
    if (!userNameformKey.currentState!.validate() ||
        !emailformKey.currentState!.validate() ||
        !phoneNumformKey.currentState!.validate() ||
        !passformKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;
      var response = await apiService.signUp(
          userNameController.text,
          emailController.text,
          phoneNumController.text,
          passwordController.text);

      if (response is SignUpResponse) {
        if (response.success == true) {
          Get.to(SignupOtpView(email: emailController.text));
        } else {
          Get.snackbar("Error", response.message ?? "User Registration Failed",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else if (response is SignUpErrorResponse) {
        // Check if email already exists
        if (response.errors != null &&
            response.errors!.email.isNotEmpty &&
            response.errors!.email
                .contains("The email has already been taken.")) {
          Get.snackbar(
              "Warning", "Email already exists. Redirecting to login...",
              backgroundColor: Colors.orange, colorText: Colors.white);
          Get.offAll(LoginView());
        } else {
          Get.snackbar("Error", response.message ?? "User Registration Failed",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred. Please try again.",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}


// Get.offAll(WhoAreYouView(
//             token: response.data!.token,
//             userName: response.data!.username,
//             id: response.data!.id,
//           ));