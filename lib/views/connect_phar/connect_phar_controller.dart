import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/models/add_thread_response_model.dart';
import 'package:pharmed_app/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async'; // Add this import

class ConnectPharController extends GetxController {
  var threadDataList = [].obs;
  ApiService apiService = ApiService();
  RxInt id = 0.obs;
  TextEditingController messageController = TextEditingController();

  RxBool isLoading = false.obs;
  RxInt currentPage = 1.obs;
  RxBool hasMoreData = true.obs;

  Timer? timer; // Declare the timer

  @override
  void onClose() {
    // Cancel the timer when the controller is disposed
    timer?.cancel();
    super.onClose();
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('id');
    if (userId != null) {
      id.value = userId;
    }
  }

  Future<void> getThreadData(String medicine) async {
    if (isLoading.value || !hasMoreData.value) return;

    isLoading.value = true;
    try {
      final response = await apiService.getThread(medicine, currentPage.value);
      if (response.data?.data.isEmpty ?? true) {
        hasMoreData.value = false;
      } else {
        threadDataList.addAll(response.data!.data); // Append at the end
        currentPage.value++;
      }
    } catch (e) {
      print('Error fetching thread data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void loadNewMessages(String medicine) async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final response = await apiService.getThread(medicine, currentPage.value);
      currentPage.value++;
      if (response.data?.data.isNotEmpty ?? false) {
        threadDataList.addAll(response.data!.data);
      }
    } catch (e) {
      print('Error fetching new messages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addThreadData(String medicine, String comment) async {
    messageController.clear();
    try {
      AddThreadResponse addThreadResponse =
          await apiService.addThread(medicine, comment);
      if (addThreadResponse.success == true) {
        threadDataList.clear();
        currentPage.value = 1;
        hasMoreData.value = true;
        await getThreadData(medicine);
      }
    } catch (e) {
      print('Error adding thread data: $e');
    }
  }
}
