import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pharmed_app/models/medical_profile_model.dart';
import 'package:pharmed_app/service/api_service.dart';
import 'package:pharmed_app/views/personalize_experience/terms_and_conditions/terms_and_conditions_view.dart';

class CreateMedicalProfileController extends GetxController {
  var uploadedCertificate = <File>[].obs;
  var uploadedMedicalLicense = <File>[].obs;
  var fileNames = <String>[].obs;
  var medicalFileNames = <String>[].obs;
  RxBool isLoading = false.obs;
  var selectedGender = ''.obs;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController instituteController = TextEditingController();
  TextEditingController fieldController = TextEditingController();

  ApiService apiService = ApiService();

    void setGender(String gender) {
    selectedGender.value = gender;
  }

  // Method to handle certificate file picking
  Future<void> pickCertificateFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      allowMultiple: true,
    );

    if (result != null) {
      for (var file in result.files) {
        uploadedCertificate.add(File(file.path!));
        fileNames.add(file.name);
      }
    }
  }

  // Method to handle medical license file picking
  Future<void> pickMedicalLicenseFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      allowMultiple: true,
    );

    if (result != null) {
      for (var file in result.files) {
        uploadedMedicalLicense.add(File(file.path!));
        medicalFileNames.add(file.name);
      }
    }
  }

  // Method to remove a file (certificate or license)
  void removeFile(int index, bool isLicense) {
    if (isLicense) {
      uploadedMedicalLicense.removeAt(index);
      medicalFileNames.removeAt(index);
    } else {
      uploadedCertificate.removeAt(index);
      fileNames.removeAt(index);
    }
  }

  // Use the service to create a medical profile
  Future<void> createMedicalProfile() async {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        instituteController.text.isEmpty ||
        fieldController.text.isEmpty ||
        uploadedCertificate.isEmpty ||
        uploadedMedicalLicense.isEmpty) {
      Get.snackbar(
        'Error',
        'All fields are required',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    try {
      MedicalProfileResponse response = await apiService.createMedicalProfile(
        fullName: firstNameController.text+lastNameController.text,
        institute: instituteController.text,
        field: fieldController.text,
        certificates: uploadedCertificate,
        gender: selectedGender.value,
        medicalLicenses: uploadedMedicalLicense,
      );

      // if (response.success != false) {
        Get.offAll(TermsAndConditionsView());
        
      // }
    } catch (e) {
       Get.snackbar(
      'Error',
      e.toString().replaceFirst('Exception: ', ''),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
      print('Error creating medical profile: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
