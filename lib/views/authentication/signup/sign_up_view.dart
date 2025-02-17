import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/authentication/signup/sign_up_controller.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'package:pharmed_app/widgets/custom_textfield.dart';
import '../login/login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final controller = Get.put(SignUpController());
  togglePasswordVisibility() {
    setState(() {
      controller.isPasswordObscured = !controller.isPasswordObscured;

      controller.eyeIcon = controller.isPasswordObscured
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
                  top: screenHeight * 0.16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'create_acc'.tr,
                      color: Colors.white,
                      fontSize: screenWidth * 0.075,
                      weight: FontWeight.w900,
                    ),
                    const SizedBox(height: 3),
                    CustomText(
                      text: 'sign_up_text'.tr,
                      color: Colors.white,
                      fontSize: screenWidth * 0.035,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Form(
                      key: controller.userNameformKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'user_name'.tr,
                            weight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            borderRadius: 8,
                            controller: controller.userNameController,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Icon(Icons.person, size: 20),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            hintText: 'enter_full_name'.tr,
                          ),
                        ],
                      ),
                    ),
                  ),
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            hintText: 'enter_email'.tr,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Form(
                      key: controller.phoneNumformKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'phone_number'.tr,
                            weight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: controller.phoneNumController,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Icon(
                                Icons.phone,
                                size: 20,
                              ),
                            ),
                            hintText: 'enter_phone'.tr,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
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
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Icon(
                                Icons.lock,
                                size: 20,
                              ),
                            ),
                            hintText: 'enter_pass'.tr,
                            obscureText: controller.isPasswordObscured,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            suffixIcon: GestureDetector(
                              onTap: togglePasswordVisibility,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 15, left: 15),
                                child: controller.eyeIcon,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.022,
                  ),
                  Obx(
                    () => CommonButton(
                      onPressed: () {
                        controller.signUp();
                      },
                      bgColor: ColorConstants.buttoncolor,
                      borderColor: ColorConstants.buttoncolor,
                      isLoading: controller.isLoading.value,
                      trailingIcon: const Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: Colors.white,
                      ),
                      title: 'signup'.tr,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "already_have_account".tr,
                        weight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xff59606E),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Get.offAll(LoginView());
                        },
                        child: CustomText(
                          text: "signin".tr,
                          weight: FontWeight.w500,
                          fontSize: 14,
                          color: ColorConstants.themecolor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
