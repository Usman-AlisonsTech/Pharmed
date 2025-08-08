import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/models/add_medication_response_model.dart';
import 'package:pharmed_app/models/medicine_info_response_model.dart';
import 'package:pharmed_app/models/popular_medication_model.dart';
import 'package:pharmed_app/models/search_response_model.dart';
import 'package:pharmed_app/service/api_service.dart';
import 'package:pharmed_app/views/search/medicine_information/medicine_information_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var medications = <Datum>[].obs;
  var searchResults = <Medication>[].obs;
  var isLoading = false.obs;
  var isSearchLoading = false.obs;
  var isAddToMedicinesLoading = false.obs;
  var isMoreDataAvailable = true.obs;
  var currentPage = 1.obs;
  final ApiService apiService = ApiService();
  var dateFields = <RxString>[].obs;
  final List<dynamic> jsonData = [];
  var storedUserName = "".obs;
  RxString translatedText = ''.obs;
  RxString translatedMedicineName = ''.obs;
  RxMap<String, String> translatedMedicines = <String, String>{}.obs;

  TextEditingController physicianName = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  TextEditingController frequencyController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

 Rx<MedicineInformationResponseModel?> medicineData = Rx<MedicineInformationResponseModel?>(null);

  @override
  void onInit() {
    fetchTranslation();
    fetchPopularMedications();
    super.onInit();
  }

  // Add new date-time field
  void addDateField() {
    dateFields.add("".obs);
  }

  // Remove a date-time field at the given index
  void removeDateField(int index) {
    if (dateFields.length > 1) {
      dateFields.removeAt(index);
    }
  }

  Future<void> loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('username');
    if (userName != null) {
      storedUserName.value = userName;
    }
    print(userName);
  }

  // Select Date and Time, then update the field
  Future<void> selectDateTime(int index) async {
    DateTime? selectedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        DateTime finalDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        String formattedDateTime =
            "${finalDateTime.year}-${finalDateTime.month.toString().padLeft(2, '0')}-${finalDateTime.day.toString().padLeft(2, '0')} "
            "${finalDateTime.hour.toString().padLeft(2, '0')}:${finalDateTime.minute.toString().padLeft(2, '0')}:00";

        dateFields[index].value = formattedDateTime; // Update the field
      }
    }
  }

  Future<void> fetchPopularMedications({bool isLoadMore = false}) async {
    if (!isMoreDataAvailable.value && isLoadMore) return;

    print(currentPage.value);

    try {
      if (!isLoadMore) {
        isLoading.value = true;
      }

      var medicationResponse =
          await apiService.popularMedication(pageNum: currentPage.value);

      if (medicationResponse != null &&
          medicationResponse.success == true &&
          medicationResponse.data != null &&
          medicationResponse.data!.data.isNotEmpty) {
        if (isLoadMore) {
          medications.addAll(medicationResponse.data!.data);
        } else {
          medications.assignAll(medicationResponse.data!.data);
        }

        currentPage.value++;
      } else {
        isMoreDataAvailable.value = false;
      }
    } catch (e) {
      if (e.toString().contains("StatusCode: 429")) {
        print("Rate limit exceeded. Retrying after delay...");
        await Future.delayed(Duration(seconds: 10));
        fetchPopularMedications(isLoadMore: isLoadMore); // Retry
      } else {
        print("Error fetching data: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

Future<void> searchMedication(String query, String medicineName) async {
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

  Future<void> addToMedicines(String medicineName, BuildContext context) async {
  try {
    isAddToMedicinesLoading.value = true;
    final Map<String, dynamic> data = {
      "physician_name": physicianName.text,
      "medicine": medicineName,
      "status": "active",
      "start_date": startDateController.text,
      "end_date": endDateController.text,
      "dosage": dosageController.text,
      "frequency": frequencyController.text,
      "reason": reasonController.text,
    };

    List<String> schedule = [];
    for (var dateField in dateFields) {
      if (dateField.value.isNotEmpty) {
        schedule.add(dateField.value);
      }
    }

    if (schedule.isNotEmpty) {
      data['schedule'] = schedule;
    }

    final AddMedication? response = await apiService.addMedication(data);

    if (response != null && response.data != null) {
      final detailsText = response.data?.issue[0].details?.text?? "Medicine added successfully";
      Get.snackbar("Success", detailsText,
          colorText: Colors.white, backgroundColor: Colors.green);

      Navigator.pop(context);

      // Clear fields
      physicianName.clear();
      startDateController.clear();
      endDateController.clear();
      dosageController.clear();
      frequencyController.clear();
      reasonController.clear();
      schedule.clear();
      dateFields.clear();
    } else {
      Get.snackbar("Error", "Failed to add medicine",
          backgroundColor: Colors.red, colorText: Colors.white);
      Navigator.pop(context);
    }
  } catch (e) {
    Get.snackbar("Error", '$e',
        backgroundColor: Colors.red, colorText: Colors.white);
  } finally {
    isAddToMedicinesLoading.value = false;
  }
}

  // Function to fetch translation from API
  Future<void> fetchTranslation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('selectedLanguage') ?? '';
    String userName = prefs.getString('username') ?? '';

    // If language is English, return default text
    if (languageCode.toLowerCase() == 'en') {
      translatedText.value = "Hello ${userName}! 👋";
      return;
    }

    try {
      // Call the API service
      http.Response response = await apiService.translateText(
        "Hello ${userName}! 👋",
        languageCode,
      );

      print('Response Status Code : ${response.statusCode}');
      print('Response Body : ${response.body}');

      // Ensure the response is properly decoded
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        final data = json.decode(utf8DecodedResponse);

        if (data['translated_data'] != null &&
            data['translated_data']['text'] != null) {
          translatedText.value = data['translated_data']['text'];
        } else {
          print('Error: Translated text not found in the response');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching translation: $e");
    }
  }

   Future<void> fetchMedicineTranslations(List<String> medicineNames) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('selectedLanguage') ?? '';

    if (languageCode.toLowerCase() == 'en') {
      // If language is English, use default names
      translatedMedicines.value = {
        for (var name in medicineNames) name: name,
      };
      return;
    }

    try {
      for (var medicineName in medicineNames) {
        if (translatedMedicines.containsKey(medicineName)) continue; // Skip if already translated

        http.Response response = await apiService.translateText(
          medicineName,
          languageCode,
        );

        if (response.statusCode == 200) {
          final utf8DecodedResponse = utf8.decode(response.bodyBytes);
          final data = json.decode(utf8DecodedResponse);

          if (data['translated_data'] != null &&
              data['translated_data']['text'] != null) {
            translatedMedicines[medicineName] = data['translated_data']['text'];
          } else {
            print('Error: Translated text not found in the response');
          }
        } else {
          print('Error: ${response.statusCode}');
        }
      }
      translatedMedicines.refresh(); // Refresh the UI after translation
    } catch (e) {
      print("Error fetching translations: $e");
    }
  }
}
