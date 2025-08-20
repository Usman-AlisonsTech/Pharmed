import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/bottombar/bottom_bar.dart';
import 'package:pharmed_app/views/personalize_experience/terms_and_conditions/terms_and_condition_controller.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_text.dart';

import '../../authentication/login/login_view.dart';

class TermsAndConditionsView extends StatefulWidget {
  const TermsAndConditionsView({super.key});

  @override
  _TermsAndConditionsViewState createState() => _TermsAndConditionsViewState();
}

class _TermsAndConditionsViewState extends State<TermsAndConditionsView> {
  // Create ScrollController
  final ScrollController _scrollController = ScrollController();

  // Variable to track the physics state
  ScrollPhysics _scrollPhysics = NeverScrollableScrollPhysics();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Initialize the controller
    final TermsAndConditionController controller =
        Get.put(TermsAndConditionController());

    void _scrollToBottom() {
      controller.hideButton();
      _scrollController
          .animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      )
          .then((_) {
        controller.hideButton();
        setState(() {
          _scrollPhysics = AlwaysScrollableScrollPhysics();
        });
      });
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics:
              _scrollPhysics, // Use the dynamic physics based on the scroll state
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.07,
                ),
                CustomText(
                  text: 'terms_condition'.tr,
                  weight: FontWeight.w900,
                  fontSize: 30,
                ),
                const SizedBox(height: 10),
                CustomText(
                  text: 'read_terms_condition'.tr,
                  color: ColorConstants.themecolor,
                  weight: FontWeight.w500,
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return HtmlWidget(
                    controller.termsHtml.value,
                    textStyle: TextStyle(fontFamily: 'Poppins'),
                  );
                }),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return Container();
                  }
                  return Column(
                    children: [
                      CommonButton(
                        onPressed: () {
                          Get.offAll(LoginView());
                        },
                        title: 'decline'.tr,
                        textColor:isDark? Colors.white : Colors.black,
                        textWeight: FontWeight.w700,
                        bgColor: isDark? Colors.grey[900]: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      CommonButton(
                        onPressed: () {
                          Get.offAll(BottomNavigation());
                        },
                        title: 'accept_terms_condition'.tr,
                        bgColor: isDark? Colors.grey[900]: Colors.black,
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        // Only show the button if it's visible
        return controller.isButtonVisible.value
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: CommonButton(
                  title: 'scroll_bottom'.tr,
                  textWeight: FontWeight.w700,
                  trailingIcon: const Icon(Icons.arrow_downward_rounded),
                  bgColor: isDark? Colors.grey[900]: Colors.white,
                  textColor:isDark? Colors.white: Colors.black,
                  onPressed: _scrollToBottom,
                ),
              )
            : const SizedBox.shrink();
      }),
    );
  }
}
