import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/models/medicine_info_response_model.dart';
import 'package:pharmed_app/models/suggestion_response_model.dart';
import 'package:pharmed_app/service/api_service.dart';
import 'package:pharmed_app/views/search/medicine_information/medicine_information_view.dart';

class SearchScreenController extends GetxController {
  TextEditingController searchController = TextEditingController();
  List<dynamic> jsonData = [];
  ApiService apiService = ApiService();
  RxBool isSearchLoading = false.obs;
  var searchResults = <Datum>[].obs;

  Rx<MedicineInformationResponseModel?> medicineData = Rx<MedicineInformationResponseModel?>(null);

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
    medicineData.value = null;
    
    Get.to(() => MedicineInformationView(
      medicineData: medicineData, 
      medicineName: medicineName,
      isLoading: isSearchLoading,
    ));

    final result = await apiService.searchMedicationInfo(query);

    if (result != null) {
      medicineData.value = result;
      print("Medicine data loaded: ${result.drug}"); 
    } else {
      print("No medications found.");
      medicineData.value = null;
    }
  } catch (e) {
    print("Error: $e");
    medicineData.value = null;
  } finally {
    isSearchLoading.value = false;
  }
}

}