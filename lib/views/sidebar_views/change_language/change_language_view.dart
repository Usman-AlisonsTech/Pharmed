import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/bottombar/bottom_bar.dart';
import 'package:pharmed_app/views/sidebar_views/change_language/change_language_controller.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_text.dart';

class ChangeLanguageView extends StatelessWidget {
  const ChangeLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final controller = Get.put(ChangeLanguageController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body:  Padding(
          padding: EdgeInsets.only(
            left: ScreenConstants.screenhorizontalPadding,
            right: ScreenConstants.screenhorizontalPadding,
            top: screenHeight * 0.055,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.arrow_back, size: 22),
              ),
              SizedBox(height: screenHeight * 0.04),
              CustomText(
                text: 'change_language'.tr,
                weight: FontWeight.w900,
                fontSize: 30,
              ),
              SizedBox(height: 15),
              CustomText(
                text: 'select_language'.tr,
                color: ColorConstants.themecolor,
                weight: FontWeight.w500,
              ),
              SizedBox(height: screenHeight * 0.05),
              // English Container
              Obx(() {
                return GestureDetector(
                  onTap: () => controller.setSelectedLanguage('en'),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color:isDark? Colors.black: ColorConstants.themecolor, width: 1),
                        color: controller.selectedLanguage.value == 'en'
                            ? ColorConstants.themecolor
                            :isDark? Color(0xFF121212): Colors.white,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     offset: Offset(0, 4),
                        //     blurRadius: 6,
                        //     spreadRadius: 1,
                        //   ),
                        // ]
                        ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'english'.tr,
                          weight: FontWeight.w700,
                          fontSize: 13,
                          color: controller.selectedLanguage.value == 'en'
                              ? Colors.white
                              :isDark? Colors.white: Colors.black,
                        ),
                        if (controller.selectedLanguage.value == 'en')
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
                  onTap: () => controller.setSelectedLanguage('ar'),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color:isDark? Colors.black: ColorConstants.themecolor, width: 1),
                      color: controller.selectedLanguage.value == 'ar'
                          ? ColorConstants.themecolor
                          :isDark? Color(0xFF121212): Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'arabic'.tr,
                          weight: FontWeight.w700,
                          fontSize: 13,
                          color: controller.selectedLanguage.value == 'ar'
                              ? Colors.white
                              : isDark? Colors.white: Colors.black,
                        ),
                        if (controller.selectedLanguage.value == 'ar')
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
                  onTap: () => controller.setSelectedLanguage('ur'),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: isDark? Colors.black: ColorConstants.themecolor, width: 1),
                      color: controller.selectedLanguage.value == 'ur'
                          ? ColorConstants.themecolor
                          : isDark? Color(0xFF121212): Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'urdu'.tr,
                          weight: FontWeight.w700,
                          fontSize: 13,
                          color: controller.selectedLanguage.value == 'ur'
                              ? Colors.white
                              : isDark? Colors.white: Colors.black,
                        ),
                        if (controller.selectedLanguage.value == 'ur')
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: CommonButton(
          title: 'update'.tr,
          trailingIcon: Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () {
            Get.offAll(BottomNavigation());
          },
          bgColor:isDark? Colors.grey[900]: Colors.black,
        ),
      ),
    );
  }
}