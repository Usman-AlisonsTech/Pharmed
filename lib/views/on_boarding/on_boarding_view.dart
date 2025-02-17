import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/on_boarding/on_boarding_controller.dart';
import 'package:pharmed_app/widgets/common_button.dart';

class OnBoardingView extends StatefulWidget {
  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final OnBoardingController _controller = Get.put(OnBoardingController());
  PageController _pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // Get screen height and width
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Obx(() {
        if (_controller.isOnboardingCompleted.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                onboardingPages[currentPage].floatingImages,
                fit: BoxFit.cover,
                width: screenWidth,
                height: screenHeight * 0.45,
              ),

              const SizedBox(height: 10),

              Container(
                height: screenHeight * 0.29,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemCount: onboardingPages.length,
                  itemBuilder: (context, index) {
                    final page = onboardingPages[index];
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              page.title,
                              style: const TextStyle(
                                  color: ColorConstants.themecolor,
                                  fontSize: 26,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w900),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              page.subtitle,
                              style: const TextStyle(
                                  color: Color(0xff59606E),
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingPages.length,
                  (dotIndex) => buildDot(dotIndex, context),
                ),
              ),
              const SizedBox(height: 30),

              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: GestureDetector(
                  onTap: () {
                    if (currentPage < onboardingPages.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    } else {
                      // Navigate to SignUpView
                     _controller.completeOnboardingSignUp();
                    }
                  },
                  child: CommonButton(
                    bgColor: Colors.black,
                    title: currentPage < 2 ? 'next'.tr : 'get_started'.tr,
                    fontSize: 15,
                  ),
                ),
              ),

              // Skip or Login Text Button
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: TextButton(
                  onPressed: () {
                    _controller.completeOnboarding();
                  },
                  child: RichText(
                    text: TextSpan(
                      text: currentPage < 2
                          ? 'skip'.tr
                          : 'already_have_account'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: currentPage < 2
                            ? Colors.black
                            : Color(ColorConstants.themeColor),
                        decorationThickness: 2.0,
                      ),
                      children: currentPage < 2
                          ? []
                          : [
                              TextSpan(
                                text: 'login'.tr,
                                style: const TextStyle(
                                    color: Color(ColorConstants.themeColor),
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2.0,
                                    decorationColor:
                                        Color(ColorConstants.themeColor)),
                              ),
                            ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 35,
              )
            ],
          ),
        );
      }),
    );
  }

  // Build each dot for pagination
  Widget buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 6),
      height: 7,
      width: currentPage == index ? 30 : 8,
      decoration: BoxDecoration(
        color: currentPage == index ? ColorConstants.themecolor : Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
