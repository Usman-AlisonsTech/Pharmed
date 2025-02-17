import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/views/splash/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController splashController = Get.find<SplashController>();
    splashController.checkFirstTime();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/png/splash_bg.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/png/app_icon.png', width: 170),
                const SizedBox(height: 20),
                Image.asset('assets/png/splash_text.png', width: 200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
