import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/views/sidebar_views/privacy_policy/privacy_policy_controller.dart';
import 'package:pharmed_app/widgets/custom_text.dart';

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  _PrivacyPolicyViewState createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  final PrivacyPolicyController controller = Get.put(PrivacyPolicyController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.arrow_back, size: 22),
                ),
                SizedBox(height: screenHeight * 0.04),
                CustomText(
                  text: 'privacy_policy'.tr,
                  weight: FontWeight.w900,
                  fontSize: 30,
                ),
                SizedBox(height: screenHeight * 0.04),
               Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: const SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(strokeWidth: 3),
                        ),
                      ),
                    );
                  }
                  return HtmlWidget(
                    controller.privacyPolicy.value,
                    textStyle: TextStyle(fontFamily: 'Poppins'),
                  );
                }),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
