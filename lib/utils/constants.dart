import 'package:flutter/material.dart';

class ApiConstants {
  static const String baseurl = 'https://pharmed.alisonstech-dev.com/API/public/api/';
  static const String login = 'patient/login';
  static const String loginOtp = 'patient/otpverify';
  static const String signUp = 'patient/create';
  static const String termsCondition = 'terms/content';
  static const String patientProfile = 'patient/details';
  static const String medicalProfile = 'doctor/create';
  static const String popularMedication = 'medications/popular';
  static const String addMedication  = 'patient/medication/add';
  static const String getMedication  =  'patient/medication/get';
  static const String updateMedication  =  'patient/medication/update';
  static const String checkDrugInteraction = 'medications/interaction/checker';
  static const String suggestion = 'medications/suggestion';
  static const String notification = 'patient/medication/';
  static const String getThread = 'medications/thread/';
  static const String addThread  = 'medications/thread/add';
  static const String privacyPolicy = 'privacy/content';
  static const String forgotPass = 'forgot_password/sendCode';
}

class ColorConstants {
  static const themeColor = 0xff52A8B0;
  static const Color buttoncolor = Color(0xff54A8B0);
  static const Color themecolor = Color(0xff54A8B0);
  static const Color bottomNavSelectColor = Color(0xff52A8B0);
}

class ScreenConstants {
  static const double screenhorizontalPadding = 25;
  static const double screenverticalPadding = 80;
}
