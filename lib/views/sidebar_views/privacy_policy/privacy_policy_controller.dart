import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pharmed_app/models/privacy_policy_model.dart';
import 'package:pharmed_app/utils/constants.dart';
class PrivacyPolicyController extends GetxController {
  var privacyPolicy = "".obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPrivacyPolicy();
  }

  Future<void> fetchPrivacyPolicy() async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiConstants.baseurl}${ApiConstants.privacyPolicy}'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final privacyPolicyResponse = PrivacyPolicyResponse.fromJson(jsonData);
        
        if (privacyPolicyResponse.success == true &&
            privacyPolicyResponse.data != null) {
          privacyPolicy.value = privacyPolicyResponse.data!.content ?? "No content available.";
        }
      } else {
        privacyPolicy.value = "Failed to load privacy policy.";
      }
    } catch (e) {
      privacyPolicy.value = "An error occurred: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
