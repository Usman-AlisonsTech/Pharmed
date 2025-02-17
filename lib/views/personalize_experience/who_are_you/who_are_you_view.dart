import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/personalize_experience/create_medical_profile/create_medical_profile_view.dart';
import 'package:pharmed_app/views/personalize_experience/create_patient_profile/create_patient_profile_view.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'who_are_you_controller.dart';

class WhoAreYouView extends StatelessWidget {
  final String? token;
  final String? userName;
  final int? id;
  const WhoAreYouView({super.key, this.token, this.userName, this.id});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    // Access the controller
    final WhoAreYouController controller = Get.put(WhoAreYouController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              CustomText(
                text: 'who_are_you'.tr,
                weight: FontWeight.w900,
                fontSize: 30,
              ),
              const SizedBox(height: 5),
              CustomText(
                text: 'are_you_a'.tr,
                color: ColorConstants.themecolor,
                weight: FontWeight.w500,
              ),
              SizedBox(
                height: screenHeight * 0.075,
              ),

              // Patient Container
              Obx(() {
                return GestureDetector(
                  onTap: () => controller.setSelectedRole('Patient'),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: ColorConstants.themecolor, width: 1),
                      color: controller.selectedRole.value == 'Patient'
                          ? ColorConstants.themecolor
                          : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(0, 4),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'patient'.tr,
                          weight: FontWeight.w700,
                          fontSize: 16,
                          color: controller.selectedRole.value == 'Patient'
                              ? Colors.white
                              : Colors.black,
                        ),
                        if (controller.selectedRole.value == 'Patient')
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

              // Medical Professional Container
              Obx(() {
                return GestureDetector(
                  onTap: () =>
                      controller.setSelectedRole('Medical Professional'),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: ColorConstants.themecolor, width: 1),
                      color: controller.selectedRole.value ==
                              'Medical Professional'
                          ? ColorConstants.themecolor
                          : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(0, 4),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'medical_professional'.tr,
                          weight: FontWeight.w700,
                          fontSize: 16,
                          color: controller.selectedRole.value ==
                                  'Medical Professional'
                              ? Colors.white
                              : Colors.black,
                        ),
                        if (controller.selectedRole.value ==
                            'Medical Professional')
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: CommonButton(
          title: 'next'.tr,
          fontSize: 14,
          onPressed: () {
            if (controller.selectedRole.value == 'Patient') {
              controller.saveToken(token,userName, id);
              Get.to(CreatePatientProfileView());
            } else if (controller.selectedRole.value ==
                'Medical Professional') {
               controller.saveToken(token, userName, id);   
              Get.to(CreateMedicalProfileView());
            } else {
              Get.snackbar('error'.tr, 'please_select_role'.tr,
                  backgroundColor: Colors.red, colorText: Colors.white);
            }
          },
          trailingIcon: Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 18,
          ),
          bgColor: Colors.black,
          // shadowColor: Colors.grey,
        ),
      ),
    );
  }
}
