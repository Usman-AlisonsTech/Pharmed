import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmed_app/models/get_medication_response_model.dart';
import 'package:pharmed_app/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyMedicalHistoryController extends GetxController {
  var dateFields = <String>[''].obs;
  ApiService apiService = ApiService();
  RxBool isLoading = false.obs;
  RxBool isPaginationLoading = false.obs;
  RxBool isUpdateLoading = false.obs;
  var medicationsList = <Datum>[].obs;
  var filteredMedicationsList = <Datum>[].obs;
  RxBool hasNextPage = true.obs;
  // RxInt currentPage = 1.obs;
  TextEditingController physicianName = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  TextEditingController frequencyController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxMap<String, String> translatedMedicines = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      filterMedications();
    });
  }

 void filterMedications() {
  String query = searchController.text.toLowerCase();
  if (query.isEmpty) {
    filteredMedicationsList.value = medicationsList;
  } else {
    filteredMedicationsList.value = medicationsList.where((medication) {
      String originalName = medication.medicationCodeableConcept?.text?.toLowerCase() ?? '';
      String translatedName =
          translatedMedicines[medication.medicationCodeableConcept?.text]?.toLowerCase() ?? '';

      return originalName.contains(query) || translatedName.contains(query);
    }).toList();
  }
}

  void addDateField() {
    dateFields.add('');
  }

  void removeDateField(int index) {
    if (dateFields.length > 1) {
      dateFields.removeAt(index);
    } else {
      Get.snackbar("Warning", "At least one schedule your doses is required.",
          backgroundColor: Colors.orange, colorText: Colors.white);
    }
  }

  // Helper function to format DateTime
  String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

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

        dateFields[index] =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(finalDateTime);
      }
    }

    // Ensure field is never empty
    if (dateFields[index].isEmpty) {
      Get.snackbar("Warning", "Schedule Your Doses field cannot be empty.",
          backgroundColor: Colors.orange, colorText: Colors.white);
      dateFields[index] =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    }
  }

  // get Medication History
  Future<void> getMedications({int page = 1}) async {
  if (page == 1) {
    isLoading.value = true;
  } else {
    isPaginationLoading.value = true;
  }

  try {
    GetMedicationResponse response = await apiService.getMedications(page: page);

    // Success condition
    if (response.data != null && response.data.isNotEmpty) {
      if (page == 1) {
        medicationsList.value = response.data;
      } else {
        medicationsList.addAll(response.data);
      }

      // hasNextPage.value = response.nextPageUrl != null;
      filteredMedicationsList.value = medicationsList;
    } else {
      Get.snackbar('No Medications', 'No medications found',
          backgroundColor: Colors.orange, colorText: Colors.white);
    }
  } catch (e) {
    print('Error fetching Medications: $e');
    Get.snackbar("Error", e.toString(),
        backgroundColor: Colors.red, colorText: Colors.white);
  } finally {
    if (page == 1) {
      isLoading.value = false;
    } else {
      isPaginationLoading.value = false;
    }
  }
}

  // Future<void> loadMoreMedications() async {
  //   // Only load more if there's a next page and not already loading
  //   if (hasNextPage.value && !isPaginationLoading.value) {
  //     currentPage.value++;
  //     await getMedications(page: currentPage.value);
  //   }
  // }

  Future<void> updateMedicines(String medicineName, int id, context) async {
  try {
    if (dateFields.any((date) => date.isEmpty)) {
      Get.snackbar("Error", "Schedule Your Doses field cannot be empty.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isUpdateLoading.value = true;

    final Map<String, dynamic> data = {
      "status": "completed",
      "physician_name": physicianName.text,
      "start_date": startDateController.text,
      "end_date": endDateController.text,
      "dosage": dosageController.text,
      "frequency": frequencyController.text,
      "reason": reasonController.text,
      "medicine": medicineName,
      "schedule": dateFields.where((date) => date.isNotEmpty).toList(),
      "_method": "PUT",
    };

    final response = await apiService.updateMedication(data, id.toString());

    if (response != null && response.data != null) {
      final message = response.data!.issue.isNotEmpty
          ? response.data!.issue.first.details?.text ?? "Medicine updated successfully."
          : "Medicine updated successfully.";

      Get.snackbar("Success", message,
          colorText: Colors.white,
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2)).future.then((_) {
        Navigator.pop(context);
        clearFields();
      });
    } else {
      Get.snackbar("Error", "Failed to update medicine",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  } catch (e) {
    print("Error updating medicine: $e");
    Get.snackbar('Error', e.toString(),
        backgroundColor: Colors.red, colorText: Colors.white);
  } finally {
    isUpdateLoading.value = false;
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
        if (translatedMedicines.containsKey(medicineName)) continue;

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
      translatedMedicines.refresh();
    } catch (e) {
      print("Error fetching translations: $e");
    }
  }

  // Function to handle translation
  Future<String> translateText(String text) async {
    const String apiUrl = "http://64.111.99.56/translate";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('selectedLanguage') ?? '';

    if (languageCode.toLowerCase() == 'en') {
      return text;
    }

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "data": {"text": text},
          "target_lang": languageCode,
        }),
      );

      if (response.statusCode == 200) {
        final utf8DecodedResponse = utf8.decode(response.bodyBytes);
        final decodedResponse = jsonDecode(utf8DecodedResponse);

        if (decodedResponse.containsKey('translated_data') &&
            decodedResponse['translated_data'].containsKey('text')) {
          return decodedResponse['translated_data']['text'];
        } else {
          return text;
        }
      } else {
        return text;
      }
    } catch (e) {
      return text;
    }
  }

  void clearFields() {
    physicianName.clear();
    startDateController.clear();
    endDateController.clear();
    dosageController.clear();
    frequencyController.clear();
    reasonController.clear();
    dateFields.clear();
  }

  @override
  void onClose() {
    super.onClose();
  }
}