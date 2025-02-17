import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/authentication/forgot_password/forgot_password_view.dart';
import 'package:pharmed_app/views/authentication/login/login_controller.dart';
import 'package:pharmed_app/views/authentication/login/login_otp/login_otp_view.dart';
import 'package:pharmed_app/views/authentication/signup/sign_up_view.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'package:pharmed_app/widgets/custom_textfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isPasswordObscured = true;
  final controller = Get.put(LoginController());
  Icon _eyeIcon = const Icon(
    Icons.remove_red_eye,
    size: 20,
  );
  bool isChecked = false;
  bool showSuffixIcon = false;
  togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;

      _eyeIcon = _isPasswordObscured
          ? const Icon(
              Icons.remove_red_eye,
              size: 20,
            )
          : const Icon(
              Icons.visibility_off,
              size: 20,
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: screenHeight * 0.33,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/png/earth.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.05,
                    right: screenWidth * 0.05,
                    top: screenHeight * 0.16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'welcome'.tr,
                      color: Colors.white,
                      fontSize: 32,
                      weight: FontWeight.w900,
                    ),
                    const SizedBox(height: 3),
                    CustomText(
                      text: 'fill_detail'.tr,
                      color: Colors.white,
                      fontSize: 14,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Form(
                      key: controller.emailformKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'email'.tr,
                            weight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: controller.emailController,
                            borderRadius: 8,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Icon(
                                Icons.email,
                                size: 20,
                              ),
                            ),
                            hintText: 'enter_email'.tr,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Form(
                      key: controller.passformKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'password'.tr,
                            weight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: controller.passwordController,
                            borderRadius: 8,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Icon(
                                Icons.lock,
                                size: 20,
                              ),
                            ),
                            hintText: 'enter_pass'.tr,
                            obscureText: _isPasswordObscured,
                            suffixIcon: GestureDetector(
                              onTap: togglePasswordVisibility,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 15, left: 15),
                                child: _eyeIcon,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }

                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(ForgotPasswordView());
                        },
                        child: CustomText(
                          text: 'forgot_pass'.tr,
                          color: ColorConstants.themecolor,
                          fontSize: 14,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  const Divider(color: Color(0xffEEEEEE)),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Obx(
                    () => CommonButton(
                        title: 'next'.tr,
                        trailingIcon: const Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: Colors.white,
                        ),
                        isLoading: controller.isLoading.value,
                        bgColor: ColorConstants.buttoncolor,
                        borderColor: ColorConstants.buttoncolor,
                        fontSize: 15,
                        textWeight: FontWeight.w700,
                        buttonShade: Colors.grey,
                        onPressed: () {
                          controller.login();
                        }),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "dont_have_acc".tr,
                        weight: FontWeight.w500,
                        fontSize: 14,
                        color: const Color(0xff59606E),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Get.to(SignUpView());
                        },
                        child: CustomText(
                          text: "register".tr,
                          weight: FontWeight.w500,
                          fontSize: 14,
                          color: ColorConstants.themecolor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
