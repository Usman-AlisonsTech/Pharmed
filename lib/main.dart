import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/localization/localization.dart';
import 'package:pharmed_app/service/notification_service.dart';
import 'package:pharmed_app/views/splash/splash_controller.dart';
import 'package:pharmed_app/views/splash/splash_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotiService().initNotification();
  final prefs = await SharedPreferences.getInstance();
  String? savedLanguage = prefs.getString('selectedLanguage') ?? 'en';
  Locale initialLocale = Locale('en', 'US');
  if (savedLanguage == 'ar') {
    initialLocale = Locale('ar', 'AE');
  } else if (savedLanguage == 'ur') {
    initialLocale = Locale('ur', 'PK');
  } else if (savedLanguage == 'en') {
    initialLocale = Locale('en', 'US');
  }
  runApp(MyApp(initialLocale: initialLocale));
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;

  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return GetMaterialApp(
      home:  SplashView(),
      debugShowCheckedModeBanner: false,
      translations: LanguageModel(),
      locale: initialLocale,
      fallbackLocale: const Locale('en', 'US'),
      title: 'Pharmed',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}