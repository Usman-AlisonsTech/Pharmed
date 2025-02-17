import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguageController extends GetxController {
  var selectedLanguage = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    loadSelectedLanguage();
  }

  // Load the selected language from SharedPreferences
  Future<void> loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('selectedLanguage');
    if (language != null) {
      selectedLanguage.value = language;
      updateLocale(language);
    }
  }

  // Save the selected language to SharedPreferences
  Future<void> saveSelectedLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);
    updateLocale(language);
  }

  // Update the app locale based on the selected language
  void setSelectedLanguage(String language) {
    selectedLanguage.value = language;
    saveSelectedLanguage(language);
    updateLocale(language);
  }

  // Update the locale of the app based on selected language
  void updateLocale(String language) {
    switch (language) {
      case 'en':
        Get.updateLocale(Locale('en', 'US'));
        break;
      case 'ar':
        Get.updateLocale(Locale('ar', 'AE'));
        break;
      case 'ur':
        Get.updateLocale(Locale('ur', 'PK'));
        break;
      default:
        Get.updateLocale(Locale('en', 'US'));
    }
  }
}