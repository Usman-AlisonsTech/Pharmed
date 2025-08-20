import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/models/profile_detail_response_model.dart';
import 'package:pharmed_app/service/api_service.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var profileData = Rxn<ProfileDetailResponse>();

  @override
  void onInit() {
    super.onInit();
    fetchProfileDetail();
  }

  Future<void> fetchProfileDetail() async {
    try {
      isLoading(true);
      final response = await ApiService().getProfileDetail();
      profileData.value = response;
    } catch (e) {
      // Get.snackbar('Error', 'Failed to load profile: $e',backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }
}