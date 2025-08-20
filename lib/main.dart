import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/localization/localization.dart';
import 'package:pharmed_app/views/splash/splash_controller.dart';
import 'package:pharmed_app/views/splash/splash_view.dart';
import 'package:pharmed_app/views/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  String? savedLanguage = prefs.getString('selectedLanguage') ?? 'en';
  Locale initialLocale = Locale('en', 'US');
  if (savedLanguage == 'ar') {
    initialLocale = const Locale('ar', 'AE');
  } else if (savedLanguage == 'ur') {
    initialLocale = const Locale('ur', 'PK');
  } else if (savedLanguage == 'en') {
    initialLocale = const Locale('en', 'US');
  }

  runApp(MyApp(initialLocale: initialLocale));
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;

  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() => GetMaterialApp(
          home: SplashView(),
          debugShowCheckedModeBanner: false,
          translations: LanguageModel(),
          locale: initialLocale,
          fallbackLocale: const Locale('en', 'US'),
          title: 'Pharmed',
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.black),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black,
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.white),
            ),
          ),
          themeMode: themeController.theme,
        ));
  }
}
