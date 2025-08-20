import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/authentication/forgot_password/otp_screen/otp_controller.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'package:pharmed_app/widgets/custom_textfield.dart';
import 'package:pinput/pinput.dart';

class OtpView extends StatefulWidget {
  final String email;
  OtpView({super.key, required this.email});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final passformKey = GlobalKey<FormState>();
  final confirmpassformKey = GlobalKey<FormState>();
  final controller = Get.put(OtpController());

  // Separate state for password visibility
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  String? otp;

  Icon _eyeIcon = const Icon(
    Icons.remove_red_eye,
    size: 20,
  );

  // Toggle password visibility for the first field
  togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }

  // Toggle password visibility for the confirm password field
  toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;


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
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    SizedBox(height: screenHeight * 0.07),
                    CustomText(
                      text: 'enter_otp'.tr,
                      color: Colors.white,
                      fontSize: 32,
                      weight: FontWeight.w900,
                    ),
                    const SizedBox(height: 3),
                    CustomText(
                      text: 'enter_otp_text'.tr,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: 'enter_otp'.tr,
                      weight: FontWeight.w500,
                      fontSize: 16),
                  const SizedBox(height: 10),
                  Center(
                    child: Pinput(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      length: 6,
                      defaultPinTheme: PinTheme(
                        width: 50,
                        height: 50,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          // color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffCDCDCD)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      onCompleted: (pin) {
                        setState(() {
                          otp = pin;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(
                          text: 'dint_recieve_code'.tr,
                          weight: FontWeight.w500,
                          fontSize: 14,
                          color: isDark? Colors.grey[400]: Color(0xff59606E)),
                      const SizedBox(width: 2),
                      GestureDetector(
                        onTap: () {
                          controller.resendOtp(widget.email);
                        },
                        child: CustomText(
                            text: 'resend'.tr,
                            weight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorConstants.themecolor),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Form(
                      key: passformKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'enter_new_password'.tr,
                            weight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: controller.newPass,
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
                                child: _isPasswordObscured
                                    ? const Icon(
                                        Icons.remove_red_eye,
                                        size: 20,
                                      )
                                    : const Icon(
                                        Icons.visibility_off,
                                        size: 20,
                                      ),
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
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Form(
                      key: confirmpassformKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'confirm_new_pass'.tr,
                            weight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: controller.confirmPass,
                            borderRadius: 8,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Icon(
                                Icons.lock,
                                size: 20,
                              ),
                            ),
                            hintText: 'enter_pass'.tr,
                            obscureText: _isConfirmPasswordObscured,
                            suffixIcon: GestureDetector(
                              onTap: toggleConfirmPasswordVisibility,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 15, left: 15),
                                child: _isConfirmPasswordObscured
                                    ? const Icon(
                                        Icons.remove_red_eye,
                                        size: 20,
                                      )
                                    : const Icon(
                                        Icons.visibility_off,
                                        size: 20,
                                      ),
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
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  Obx(
                    () => CommonButton(
                        title: 'update_password'.tr,
                        isLoading: controller.isLoading.value,
                        bgColor: ColorConstants.buttoncolor,
                        borderColor: ColorConstants.buttoncolor,
                        fontSize: 15,
                        textWeight: FontWeight.w700,
                        buttonShade: Colors.grey,
                        onPressed: () {
                          controller.updatePassword(otp ?? '', widget.email);
                        }),
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
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
