import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmed_app/models/notification_response_model.dart';
import 'package:pharmed_app/service/api_service.dart';
import 'package:pharmed_app/service/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationController extends GetxController {
  var isLoading = false.obs;
  var notifications = <Datum>[].obs;
  final ApiService apiService = ApiService();
  RxMap<String, String> translatedMedicines = <String, String>{}.obs;
  RxMap<String, String> translatedFrequency = <String, String>{}.obs;
  final NotiService notiService = NotiService();

  @override
  void onInit() {
    super.onInit();
    tz.initializeTimeZones();
  }

  String getFormattedDate(DateTime date) {
    DateTime today = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(date) == DateFormat('yyyy-MM-dd').format(today) ? "today".tr : "";
  }

  Future<void> fetchNotifications(String selectedDate) async {
    try {
      isLoading(true);
      final jsonData = await apiService.medicineNotification(selectedDate);

      if (jsonData != null && jsonData['success'] == true) {
        var notificationResponse = NotificationResponse(
          success: jsonData['success'],
          data: (jsonData['data'] as List).map((item) => Datum.fromJson(item)).toList(),
          message: jsonData['message'],
        );

        notifications.assignAll(notificationResponse.data);

        // for (var notification in notificationResponse.data) {
        //   if(Platform.isIOS){
        //     scheduleMedicineNotification(notification);
        //   }else if(Platform.isAndroid){
        //     // notiService.showNotification(title: 'Take Your Medicine ${notification.medicalHistory.medicine}');
        //     scheduleMedicineNotification(notification);
        //   }
        // }
      } else {
        print("Error: Failed to fetch notifications.");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading(false);
    }
  }

void scheduleMedicineNotification(Datum notification) {
  try {
    // Parsing schedule from API response
    DateTime scheduledTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(notification.schedule.toString());

    // Convert to local timezone
    final tz.TZDateTime scheduledDate = tz.TZDateTime.from(scheduledTime, tz.local);

    notiService.scheduleNotification(
      id: notification.id ?? 0,
      title: "Medicine Reminder",
      body: "Take your medicine: ${notification.medicalHistory.medicine}",
      scheduledDate: scheduledDate,
    );

    print("Notification scheduled for: $scheduledDate");
  } catch (e) {
    print("Error scheduling notification: $e");
  }
}


  Future<void> fetchMedicineTranslations(List<String> medicineNames) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('selectedLanguage') ?? '';

    if (languageCode.toLowerCase() == 'en') {
      translatedMedicines.value = {for (var name in medicineNames) name: name};
      return;
    }

    try {
      for (var medicineName in medicineNames) {
        if (translatedMedicines.containsKey(medicineName)) continue;

        http.Response response = await apiService.translateText(medicineName, languageCode);

        if (response.statusCode == 200) {
          final utf8DecodedResponse = utf8.decode(response.bodyBytes);
          final data = json.decode(utf8DecodedResponse);

          if (data['translated_data']?['text'] != null) {
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

  Future<void> fetchFrequencyTranslations(List<String> frequency) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('selectedLanguage') ?? '';

    if (languageCode.toLowerCase() == 'en') {
      translatedFrequency.value = {for (var name in frequency) name: name};
      return;
    }

    try {
      for (var medicineName in frequency) {
        if (translatedFrequency.containsKey(medicineName)) continue;

        http.Response response = await apiService.translateText(medicineName, languageCode);

        if (response.statusCode == 200) {
          final utf8DecodedResponse = utf8.decode(response.bodyBytes);
          final data = json.decode(utf8DecodedResponse);

          if (data['translated_data']?['text'] != null) {
            translatedFrequency[medicineName] = data['translated_data']['text'];
          } else {
            print('Error: Translated text not found in the response');
          }
        } else {
          print('Error: ${response.statusCode}');
        }
      }
      translatedFrequency.refresh();
    } catch (e) {
      print("Error fetching translations: $e");
    }
  }
}
