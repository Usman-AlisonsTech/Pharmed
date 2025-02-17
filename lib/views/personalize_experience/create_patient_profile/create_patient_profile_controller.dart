import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/models/patient_profile_response_model.dart';
import 'package:pharmed_app/service/api_service.dart';
import 'package:pharmed_app/views/personalize_experience/terms_and_conditions/terms_and_conditions_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateYourProfileController extends GetxController {
  var selectedDOB = ''.obs;
  var selectedGender = ''.obs;
  var selectedCountry = ''.obs;
  TextEditingController fullName = TextEditingController();
  TextEditingController weight = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final apiService = ApiService();
  RxBool isLoading = false.obs;

  void setDOB(String date) {
    selectedDOB.value = date;
    print(selectedDOB);
  }

  void setGender(String gender) {
    selectedGender.value = gender;
  }

  void setCountry(String country) {
    selectedCountry.value = country;
  }

  // API call to create patient profile using service
  Future<void> createPatientProfile() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('selectedLanguage') ?? 'en';
    if (fullName.text.isEmpty ||
        selectedDOB.value.isEmpty ||
        selectedGender.value.isEmpty ||
        selectedCountry.value.isEmpty ||
        weight.text.isEmpty) {
      Get.snackbar('Validation Error', 'All fields must be filled');
      return;
    }

    try {
      PatientProfileResponse response = await apiService.createPatientProfile(
          name: fullName.text,
          dob: selectedDOB.value,
          gender: selectedGender.value,
          nationality: selectedCountry.value,
          weight: weight.text,
          lang: savedLanguage);

      if (response.success ?? false) {
        Get.offAll(TermsAndConditionsView());
      } else {
        Get.snackbar('Error', response.message ?? 'Something went wrong',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }finally{
      isLoading.value = false;
    }
  }
}
