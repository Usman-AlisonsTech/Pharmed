import 'dart:convert';
import 'package:get/get.dart';
import 'package:pharmed_app/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DrugsDetailController extends GetxController {
  RxList<String> translatedDetails = <String>[].obs;
  RxString translatedDrugNames = ''.obs;
  final ApiService apiService = ApiService();

  Future<void> fetchTranslations(List<String> details) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('selectedLanguage') ?? '';

    if (languageCode.toLowerCase() == 'en') {
      translatedDetails.value = details;
      return;
    }

    try {
      List<String> tempTranslatedList = [];
      for (var detail in details) {
        http.Response response =
            await apiService.translateText(detail, languageCode);

        if (response.statusCode == 200) {
          final utf8DecodedResponse = utf8.decode(response.bodyBytes);
          final data = json.decode(utf8DecodedResponse);

          if (data['translated_data'] != null &&
              data['translated_data']['text'] != null) {
            tempTranslatedList.add(data['translated_data']['text']);
          } else {
            tempTranslatedList.add(detail);
          }
        } else {
          tempTranslatedList.add(detail);
        }
      }
      translatedDetails.value = tempTranslatedList;
    } catch (e) {
      print("Error fetching translation: $e");
      translatedDetails.value = details;
    }
  }

  Future<void> fetchDrugNameTranslations(List<String> drugNames) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('selectedLanguage') ?? '';

    if (languageCode.toLowerCase() == 'en') {
      translatedDrugNames.value = drugNames.join(', ');
      return;
    }

    try {
      List<String> translatedDrugs = [];
      for (String drug in drugNames) {
        http.Response response =
            await apiService.translateText(drug, languageCode);

        if (response.statusCode == 200) {
          final utf8DecodedResponse = utf8.decode(response.bodyBytes);
          final data = json.decode(utf8DecodedResponse);

          if (data['translated_data'] != null &&
              data['translated_data']['text'] != null) {
            translatedDrugs.add(data['translated_data']['text']);
          } else {
            translatedDrugs.add(drug);
          }
        } else {
          translatedDrugs.add(drug);
        }
      }

      translatedDrugNames.value = translatedDrugs.join(', ');
    } catch (e) {
      print("Error fetching drug name translation: $e");
      translatedDrugNames.value = drugNames.join(', ');
    }
  }
}
