import 'package:get/get.dart';
import 'package:pharmed_app/views/authentication/login/login_view.dart';
import 'package:pharmed_app/views/bottombar/bottom_bar.dart';
import 'package:pharmed_app/views/personalize_splash/personalize_splash_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../on_boarding/on_boarding_view.dart';

class SplashController extends GetxController {
  var isFirstTime = true.obs;
  var isLoggedIn = false.obs;
  var isLanguageSelected = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLanguage();
  }

  Future<void> completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isOnboardingComplete', false);
  }

  Future<void> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstTime.value = prefs.getBool('isOnboardingComplete') ?? true;
    isLoggedIn.value = prefs.getString('loggedInToken') != null;

    await Future.delayed(const Duration(seconds: 2));
    navigateBasedOnState();
  }

  // Check if a language has been selected
  Future<void> checkLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLanguageSelected.value = prefs.getString('selectedLanguage') != null;
  }

  void navigateBasedOnState() {
    if (isLanguageSelected.value) {
      if (isLoggedIn.value) {
        Get.offAll(BottomNavigation());
      } else if(isFirstTime.value){
        Get.offAll(OnBoardingView());
      }
       else  {
        Get.offAll(LoginView());
      }
    } else {
      Get.offAll(PersonalizeSplashView());
    }
  }
}
