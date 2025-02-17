import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'package:pharmed_app/widgets/custom_textfield.dart';
import 'create_medical_profile_controller.dart'; // Import the controller

class CreateMedicalProfileView extends StatelessWidget {
  const CreateMedicalProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateMedicalProfileController controller =
        Get.put(CreateMedicalProfileController());

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                CustomText(
                  text: 'create_own_profile'.tr,
                  weight: FontWeight.w900,
                  fontSize: 30,
                ),
                const SizedBox(height: 10),
                CustomText(
                  text: 'enter_detail'.tr,
                  color: ColorConstants.themecolor,
                  weight: FontWeight.w500,
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                // Full Name
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'full_name'.tr,
                        weight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      const SizedBox(height: 10),
                      // Use TextFormField for validation
                      CustomTextField(
                        controller: controller.fullNameController,
                        borderRadius: 8,
                        hintText: 'enter_full_name'.tr,
                        borderColor: Colors.grey,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null; // Return null if no error
                        },
                      ),
                    ],
                  ),
                ),
                // Institute
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'institute'.tr,
                        weight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: controller.instituteController,
                        borderRadius: 8,
                        hintText: 'enter_institute'.tr,
                        borderColor: Colors.grey,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the institute';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                // Field
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'field'.tr,
                        weight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: controller.fieldController,
                        hintText: 'enter_field'.tr,
                        borderColor: Colors.grey,
                        borderRadius: 8,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the field';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                // Upload Certificate Section
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: 'upload_certificate'.tr,
                          fontSize: 16,
                          weight: FontWeight.w500),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: controller
                            .pickCertificateFiles, // Call for certificate
                        child: Image.asset('assets/png/upload_file.png'),
                      ),
                      const SizedBox(height: 10),
                      Obx(() {
                        return controller.uploadedCertificate.isNotEmpty
                            ? Column(
                                children: List.generate(
                                  controller.uploadedCertificate.length,
                                  (index) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: CustomText(
                                          text: controller.fileNames[index],
                                          weight: FontWeight.w500,
                                          color: Colors.black,
                                          textOverflow: TextOverflow.ellipsis,
                                          fontSize: 14,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.close,
                                            color: Colors.red),
                                        onPressed: () => controller.removeFile(
                                            index, false), // Remove certificate
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container();
                      }),
                    ],
                  ),
                ),

                // Upload Medical License Section
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: 'upload_medical_license'.tr,
                          fontSize: 16,
                          weight: FontWeight.w500),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: controller
                            .pickMedicalLicenseFiles, // Call for medical license
                        child: Image.asset('assets/png/upload_file.png'),
                      ),
                      const SizedBox(height: 10),
                      Obx(() {
                        return controller.uploadedMedicalLicense.isNotEmpty
                            ? Column(
                                children: List.generate(
                                  controller.uploadedMedicalLicense.length,
                                  (index) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: CustomText(
                                          text: controller
                                              .medicalFileNames[index],
                                          weight: FontWeight.w500,
                                          color: Colors.black,
                                          textOverflow: TextOverflow.ellipsis,
                                          fontSize: 14,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.close,
                                            color: Colors.red),
                                        onPressed: () => controller.removeFile(
                                            index,
                                            true), // Remove medical license
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container();
                      }),
                    ],
                  ),
                ),

                // Next Button
                SizedBox(height: screenHeight * 0.07),
                Obx(
                  () => CommonButton(
                    onPressed: () {
                      controller.createMedicalProfile();
                    },
                    isLoading: controller.isLoading.value,
                    title: 'next'.tr,
                    bgColor: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
