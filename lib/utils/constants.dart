import 'package:flutter/material.dart';

class ApiConstants {
  // static const String baseurl = 'https://pharmed.alisonstech-dev.com/API/public/api/';
  // static const String baseurl = 'http://ec2-3-29-110-146.me-central-1.compute.amazonaws.com/backend/api/';
  static const String baseurl = 'http://192.168.18.221:8000/api/r4/';
  static const String login = 'Auth/login';
  static const String loginOtp = 'Auth/otpverify';
  static const String signUp = 'Person';
  static const String termsCondition = 'Policy/terms';
  static const String patientProfile = 'Patient';
  static const String medicalProfile = 'Practitioner';
  static const String deleteAccount = 'user/delete';
  static const String delAccOtpVerify = 'user/verifydelete';
  static const String popularMedication = 'Medication/popular';
  static const String addMedication  = 'MedicationStatement';
  static const String getMedication  =  'Patients/medication/get';
  static const String updateMedication  =  'MedicationStatement';
  static const String checkDrugInteraction = 'Medication/interaction/checker';
  static const String suggestion = 'Medication/suggestion';
  static const String notification = 'Patients/medication/';
  static const String getThread = 'Medication/thread/';
  static const String addThread  = 'Medication/thread/add';
  static const String privacyPolicy = 'Policy/privacy';
  static const String forgotPass = 'Auth/forgot_password';
  static const String getProfileDetail = 'Patient';
  static const String secretKey = 'usman';
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
