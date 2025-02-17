import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/on_boarding/on_boarding_view.dart';
import 'package:pharmed_app/views/personalize_splash/personalize_splash_controller.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_text.dart';

class PersonalizeSplashView extends StatelessWidget {
  const PersonalizeSplashView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    final PersonalizeSplashController languageController =
        Get.put(PersonalizeSplashController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'personalise_experience'.tr,
                weight: FontWeight.w900,
                fontSize: 30,
              ),
              const SizedBox(height: 10),
              CustomText(
                text: 'fill_detail'.tr,
                color: ColorConstants.themecolor,
                weight: FontWeight.w500,
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),

              // English Container
              Obx(() {
                return GestureDetector(
                  onTap: () => languageController.setSelectedLanguage('en'),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: ColorConstants.themecolor, width: 1),
                        color: languageController.selectedLanguage.value == 'en'
                            ? ColorConstants.themecolor
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(0, 4),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ]),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'english'.tr,
                          weight: FontWeight.w700,
                          fontSize: 13,
                          color:
                              languageController.selectedLanguage.value == 'en'
                                  ? Colors.white
                                  : Colors.black,
                        ),
                        if (languageController.selectedLanguage.value == 'en')
                          const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 15),

              // Arabic Container
              Obx(() {
                return GestureDetector(
                  onTap: () => languageController.setSelectedLanguage('ar'),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: ColorConstants.themecolor, width: 1),
                        color: languageController.selectedLanguage.value == 'ar'
                            ? ColorConstants.themecolor
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(0, 4),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ]),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'arabic'.tr,
                          weight: FontWeight.w700,
                          fontSize: 13,
                          color:
                              languageController.selectedLanguage.value == 'ar'
                                  ? Colors.white
                                  : Colors.black,
                        ),
                        if (languageController.selectedLanguage.value == 'ar')
                          const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 15),

              // Urdu Container
              Obx(() {
                return GestureDetector(
                  onTap: () => languageController.setSelectedLanguage('ur'),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: ColorConstants.themecolor, width: 1),
                        color: languageController.selectedLanguage.value == 'ur'
                            ? ColorConstants.themecolor
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(0, 4),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ]),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'urdu'.tr,
                          weight: FontWeight.w700,
                          fontSize: 13,
                          color:
                              languageController.selectedLanguage.value == 'ur'
                                  ? Colors.white
                                  : Colors.black,
                        ),
                        if (languageController.selectedLanguage.value == 'ur')
                          const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: CommonButton(
          title: 'next'.tr,
          trailingIcon: Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () async {
            if (languageController.selectedLanguage.value.isEmpty) {
              languageController.setSelectedLanguage('en');
            } else {
              await languageController.saveSelectedLanguage(
                  languageController.selectedLanguage.value);
            }
            Get.offAll(OnBoardingView());
          },
          bgColor: Colors.black,
        ),
      ),
    );
  }
}