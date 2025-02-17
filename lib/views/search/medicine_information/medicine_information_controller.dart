import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pharmed_app/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicineInformationController extends GetxController {
  var isLoading = false.obs;
  var translatedMedicineName = ''.obs;
  var dateFields = <RxString>[].obs;
  TextEditingController physicianName = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  TextEditingController frequencyController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  var isAddToMedicinesLoading = false.obs;

  ApiService apiService = ApiService();

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

  Future<void> addToMedicines(String medicineName, BuildContext context) async {
    try {
      isAddToMedicinesLoading.value = true;
      final Map<String, dynamic> data = {
        "physician_name": physicianName.text,
        "start_date": startDateController.text,
        "end_date": endDateController.text,
        "dosage": dosageController.text,
        "frequency": frequencyController.text,
        "reason": reasonController.text,
        "medicine": medicineName,
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

      final success = await apiService.addMedication(data);

      if (success != null) {
        Get.snackbar("Success", "Medicine added successfully",
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
        Get.snackbar(
          "Error",
          "Failed to add medicine",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    } finally {
      isAddToMedicinesLoading.value = false;
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
}