import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/authentication/login/login_otp/login_otp_controller.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'package:pinput/pinput.dart';

class LoginOtpView extends StatefulWidget {
  final String email;
  LoginOtpView({super.key, required this.email});

  @override
  State<LoginOtpView> createState() => _LoginOtpViewState();
}

class _LoginOtpViewState extends State<LoginOtpView> {
  final controller = Get.put(LoginOtpController());
  String? otp;

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
                      text: 'enter_login_otp'.tr,
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
                          color: Colors.black,
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
                          color: const Color(0xff59606E)),
                      const SizedBox(width: 2),
                      GestureDetector(
                        onTap: () {
                          controller.resendOtp();
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
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  Obx(
                    () => CommonButton(
                      isLoading:  controller.isLoading.value,
                      title: 'login'.tr,
                      bgColor: ColorConstants.buttoncolor,
                      borderColor: ColorConstants.buttoncolor,
                      fontSize: 15,
                      textWeight: FontWeight.w700,
                      trailingIcon: const Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        controller.loginOtp(widget.email, otp ?? '');
                      },
                      buttonShade: Colors.grey,
                    ),
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
