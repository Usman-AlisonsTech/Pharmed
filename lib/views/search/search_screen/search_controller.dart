import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/models/suggestion_response_model.dart';
import 'package:pharmed_app/service/api_service.dart';
import 'package:pharmed_app/views/search/medicine_information/medicine_information_view.dart';

class SearchScreenController extends GetxController {
  TextEditingController searchController = TextEditingController();
  List<dynamic> jsonData = [];
  ApiService apiService = ApiService();
  RxBool isSearchLoading = false.obs;
  var searchResults = <Datum>[].obs;

  clearSearchField() {
    searchController.clear();
    jsonData.clear();
  }

  Future<void> searchMedication(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      isSearchLoading.value = true;
      final suggestionResponse = await apiService.searchMedication(query);

      if (suggestionResponse != null &&
          suggestionResponse.success == true &&
          suggestionResponse.data.isNotEmpty) {
        searchResults.assignAll(suggestionResponse.data);
      } else {
        searchResults.clear();
      }
    } catch (e) {
      print("Error fetching medication suggestions: $e");
      searchResults.clear();
    } finally {
      isSearchLoading.value = false;
    }
  }

  Future<void> searchMedicationInfo(String query, String medicineName) async {
    try {
      isSearchLoading.value = true;
      jsonData.clear();
      Get.to(() => MedicineInformationView(
            jsonData: jsonData,
            medicineName: medicineName,
            isLoading: isSearchLoading,
          ));

      final result = await apiService.searchMedicationInfo(query);

      if (result != null && result.isNotEmpty) {
        jsonData.assignAll(result);
      } else {
        print("No medications found.");
        jsonData.assignAll([
          {"message": "No Search History"}
        ]);
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isSearchLoading.value = false;
    }
  }
}
