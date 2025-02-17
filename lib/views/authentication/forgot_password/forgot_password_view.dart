import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/authentication/forgot_password/forgot_password_controller.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'package:pharmed_app/widgets/custom_textfield.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final emailformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final controller = Get.put(ForgotPasswordController());

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
                    top: screenHeight * 0.07),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    SizedBox(height: screenHeight * 0.06),
                    CustomText(
                      text: 'forgot_pass'.tr,
                      color: Colors.white,
                      fontSize: 30,
                      weight: FontWeight.w900,
                    ),
                    const SizedBox(height: 3),
                    CustomText(
                      text: 'forgot_pass_text'.tr,
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
                      key: emailformKey,
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
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  // const Divider(color: Color(0xffEEEEEE)),
                  SizedBox(
                    height: screenHeight * 0.25,
                  ),
                  Obx(
                    () => CommonButton(
                        title: 'sent_otp'.tr,
                        trailingIcon: const Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: Colors.white,
                        ),
                        bgColor: ColorConstants.buttoncolor,
                        borderColor: ColorConstants.buttoncolor,
                        fontSize: 15,
                        isLoading: controller.isLoading.value,
                        textWeight: FontWeight.w700,
                        buttonShade: Colors.grey,
                        onPressed: () {
                          controller.sendOtp();
                        }),
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
