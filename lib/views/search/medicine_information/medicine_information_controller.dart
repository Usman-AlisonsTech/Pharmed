import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MedicineInformationController extends GetxController {
  var isLoading = false.obs;
  var translatedMedicineName = ''.obs;

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