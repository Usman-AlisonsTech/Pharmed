import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalizeSplashController extends GetxController {
  var selectedLanguage = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    loadSelectedLanguage();
  }

  Future<void> loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('selectedLanguage');
    if (languageCode != null) {
      selectedLanguage.value = languageCode;
      updateLocale(languageCode);
    }
  }

  Future<void> saveSelectedLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', languageCode);
    updateLocale(languageCode);
  }

  void setSelectedLanguage(String languageCode) {
    selectedLanguage.value = languageCode;
    saveSelectedLanguage(languageCode);
  }

  void updateLocale(String languageCode) {
    switch (languageCode) {
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