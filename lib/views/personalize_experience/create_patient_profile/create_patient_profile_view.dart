import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/personalize_experience/create_patient_profile/create_patient_profile_controller.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'package:pharmed_app/widgets/custom_textfield.dart';

class CreatePatientProfileView extends StatelessWidget {
  const CreatePatientProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateYourProfileController controller =
        Get.put(CreateYourProfileController());
    double screenHeight = MediaQuery.of(context).size.height;

    // Function to pick the date and set the date in MM/DD/YYYY format
   Future<void> _selectDate(BuildContext context) async {
  DateTime initialDate = DateTime.now();
  DateTime firstDate = DateTime(1900);
  DateTime lastDate = DateTime(2050);

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );

  if (pickedDate != null) {
    // Format date as YYYY-MM-DD
    String formattedDate = "${pickedDate.year}-"
        "${pickedDate.month.toString().padLeft(2, '0')}-"
        "${pickedDate.day.toString().padLeft(2, '0')}";
    controller.setDOB(formattedDate);
  }
}

    // Function to open the country picker dialog
    void _showCountryPicker() {
      showCountryPicker(
        context: context,
        onSelect: (Country country) {
          controller.setCountry(country.name);
        },
        countryListTheme: CountryListThemeData(
          flagSize: 25,
          backgroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16, color: Colors.black),
          borderRadius: BorderRadius.circular(15),
          inputDecoration: InputDecoration(
            hintText: 'Search a country...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
            child: Form(
              key: controller.formKey,
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
                        CustomTextField(
                          controller: controller.fullName,
                          borderRadius: 8,
                          hintText: 'enter_full_name'.tr,
                          borderColor: Colors.grey,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'date_of_birth'.tr,
                          weight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        const SizedBox(height: 10),
                        Obx(() {
                          return CustomTextField(
                            borderRadius: 8,
                            controller: TextEditingController(
                              text: controller.selectedDOB.value,
                            ),
                            hintText: 'birthday'.tr,
                            readOnly: true,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: IconButton(
                                icon:
                                    const Icon(Icons.calendar_month, size: 20),
                                onPressed: () => _selectDate(context),
                              ),
                            ),
                            borderColor: Colors.grey,
                          );
                        }),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'gender'.tr,
                          weight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        const SizedBox(height: 10),
                        Obx(() {
                          return Container(
                            width: double.infinity,
                            child: DropdownButtonFormField<String>(
                              value: controller.selectedGender.value.isEmpty
                                  ? null
                                  : controller.selectedGender.value,
                              hint: Text(
                                'select_gender'.tr,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontFamily: 'Poppins'),
                              ),
                              isDense: true,
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                controller.setGender(newValue!);
                                if (newValue != 'female') {
                                  controller.setPregnancy('');
                                  controller.setTerms(0);
                                } else {
                                  controller.setPregnancy('No');
                                  controller.setTerms(0);
                                }
                              },
                              items: ['male', 'female']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(value),
                                  ),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                ),
                              ),

                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  Obx(() => Visibility(
                        visible: controller.selectedGender.value == 'female',
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'pregnancy'.tr,
                                weight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                child: DropdownButtonFormField<String>(
                                  value: controller.selectPregnancy.value.isEmpty
                                      ? null
                                      : controller.selectPregnancy.value,
                                  hint: Text(
                                    'select_pregnancy'.tr,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontFamily: 'Poppins'),
                                  ),
                                  isDense: true,
                                  isExpanded: true,
                                  onChanged: (String? newValue) {
                                    controller.setPregnancy(newValue!);
                                    if (newValue != 'Yes') {
                                      controller.setTerms(0);
                                    }
                                  },
                                  items: ['Yes', 'No']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(value),
                                      ),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (controller.selectedGender.value ==
                                            'Female' &&
                                        (value == null || value.isEmpty)) {
                                      return 'Please select pregnancy status';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  // Trimester Dropdown (Visible only when Pregnancy is Yes)
                  Obx(() => Visibility(
                        visible: controller.selectPregnancy.value == 'Yes',
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'trimester'.tr,
                                weight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                child: DropdownButtonFormField<String>(
                                  value: controller.selectTerms.value == 0
                                      ? null
                                      : {
                                          1: 'First Trimester',
                                          2: 'Second Trimester',
                                          3: 'Third Trimester',
                                        }[controller.selectTerms.value],
                                  hint: Text(
                                    'select_trimester'.tr,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontFamily: 'Poppins'),
                                  ),
                                  isDense: true,
                                  isExpanded: true,
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      final termValue = {
                                        'First Trimester': 1,
                                        'Second Trimester': 2,
                                        'Third Trimester': 3,
                                      }[newValue]!;
                                      controller.setTerms(termValue);
                                    }
                                  },
                                  items: [
                                    'First Trimester',
                                    'Second Trimester',
                                    'Third Trimester'
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(value),
                                      ),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (controller.selectPregnancy.value ==
                                            'Yes' &&
                                        (value == null || value.isEmpty)) {
                                      return 'Please select trimester';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                   Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'nationality'.tr,
                          weight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        const SizedBox(height: 10),
                        Obx(() {
                          return CustomTextField(
                            controller: TextEditingController(
                              text: controller.selectedCountry.value,
                            ),
                            hintText: 'select_nationality'.tr,
                            borderRadius: 8,
                            readOnly: true,
                            borderColor: Colors.grey,
                            suffixIcon: GestureDetector(
                              onTap: _showCountryPicker,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Icon(Icons.arrow_drop_down),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'address'.tr,
                          weight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: controller.address,
                          hintText: 'enter_address'.tr,
                          borderColor: Colors.grey,
                          borderRadius: 8,
                        ),
                      ],
                    ),
                  ),
                   CustomText(
                          text: 'martial_status'.tr,
                          weight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        const SizedBox(height: 10),
                   Obx(() {
        return Container(
          width: double.infinity,
          child: DropdownButtonFormField<String>(
            value: controller.selectMartialStatus.value.isEmpty
                ? null
                : controller.selectMartialStatus.value, 
            hint: Text(
              'select_marital_status'.tr,
              style: const TextStyle(
                  color: Colors.grey, fontSize: 14, fontFamily: 'Poppins'),
            ),
            isDense: true,
            isExpanded: true,
            onChanged: (String? newValue) {
              controller.setMartialStatus(newValue!);
            },
            items: ['single', 'married'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(value),
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 25),
            ),
          ),
        );
      }),
                        SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'birth_place'.tr,
                          weight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: controller.birthPlace,
                          hintText: 'enter_birthplace'.tr,
                          borderColor: Colors.grey,
                          borderRadius: 8,
                        ),
                      ],
                    ),
                  ),
                    Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'weight'.tr,
                          weight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: controller.weight,
                          hintText: 'enter_weight'.tr,
                          borderColor: Colors.grey,
                          borderRadius: 8,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.07),
                  Obx(
                    () => CommonButton(
                      onPressed: () {
                        if (controller.formKey.currentState?.validate() ??
                            false) {
                          controller.createPatientProfile();
                        }
                      },
                      title: 'next'.tr,
                      bgColor: Colors.black,
                      isLoading: controller.isLoading.value,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}