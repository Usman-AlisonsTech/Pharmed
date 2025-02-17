import 'package:get/get.dart';
import 'package:pharmed_app/views/authentication/login/login_view.dart';
import 'package:pharmed_app/views/authentication/signup/sign_up_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage {
  final String title;
  final String subtitle;
  final String mainImage; 
  final String floatingImages;

  OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.mainImage,
    required this.floatingImages,
  });
}

List<OnboardingPage> onboardingPages = [
  OnboardingPage(
    title: "onboard_1_heading".tr,
    subtitle:
        "onboard_1_text".tr,
    mainImage: "assets/images/person.png",
    floatingImages: 'assets/png/onboarding1.png',
  ),
  OnboardingPage(
    title: "onboard_2_heading".tr,
    subtitle:
       "onboard_2_text".tr,
    mainImage: "assets/images/person.png",
    floatingImages: 'assets/png/onboarding2.png',
  ),
  OnboardingPage(
    title: "onboard_3_heading".tr,
    subtitle: "onboard_3_text".tr,
    mainImage: "assets/images/person2.png",
    floatingImages: 'assets/png/onboarding3.png',
  ),
];

class OnBoardingController extends GetxController {
  var isOnboardingCompleted = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isOnboardingCompleted.value =
        prefs.getBool('onboarding_completed') ?? false;

    if (isOnboardingCompleted.value) {
      // Navigate to AuthGate if onboarding is completed
      Get.off(LoginView());
    }
  }

  Future<void> completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    isOnboardingCompleted.value = true;
    // Navigate to AuthGate after completing onboarding
    Get.off(LoginView());
  }

  Future<void> completeOnboardingSignUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    isOnboardingCompleted.value = true;
    // Navigate to AuthGate after completing onboarding
    Get.off(SignUpView());
  }
}
