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
  var selectPregnancy = ''.obs;
  var selectTerms = 0.obs;
  var selectMartialStatus = ''.obs;
  TextEditingController fullName = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController birthPlace = TextEditingController();
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

    void setPregnancy(String pregnancy) {
    selectPregnancy.value = pregnancy;
  }

  void setTerms(int terms) {
    selectTerms.value = terms;
    print(selectTerms);
  }

  void setMartialStatus(String status) {
    selectMartialStatus.value = status;
    print(selectMartialStatus);
  }

  // API call to create patient profile using service
 Future<void> createPatientProfile() async {
  isLoading.value = true;
  final prefs = await SharedPreferences.getInstance();
  String? savedLanguage = prefs.getString('selectedLanguage') ?? 'en';
  String? email = prefs.getString('email') ?? '';
  String? phone = prefs.getString('phone') ?? '';

  if (fullName.text.isEmpty) {
    isLoading.value = false;
    Get.snackbar('Validation Error', 'Required fields must be filled');
    return;
  }

  try {
    PatientProfileResponse response = await apiService.createPatientProfile(
      name: fullName.text,
      dob: selectedDOB.value,
      gender: selectedGender.value,
      nationality: selectedCountry.value,
      weight: weight.text,
      lang: savedLanguage,
      term: selectTerms.value,
      phone: phone,
      email: email,
      address: address.text,
      maritalStatus: selectMartialStatus.value,
      birthPlace: birthPlace.text,
    );

    if (response.data != null) {
      Get.snackbar('Success', 'Patient profile created successfully', backgroundColor: Colors.green, colorText: Colors.white);
      Get.offAll(TermsAndConditionsView());
    } else {
      Get.snackbar('Error', 'Something went wrong',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  } catch (e) {
    Get.snackbar('Error', '$e',
        backgroundColor: Colors.red, colorText: Colors.white);
  } finally {
    isLoading.value = false;
  }
}
}
