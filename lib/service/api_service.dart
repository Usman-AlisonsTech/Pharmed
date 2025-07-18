import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pharmed_app/models/add_medication_response_model.dart';
import 'package:pharmed_app/models/add_thread_response_model.dart';
import 'package:pharmed_app/models/drug_interaction_response_model.dart';
import 'package:pharmed_app/models/get_medication_response_model.dart';
import 'package:pharmed_app/models/login_otp_response_model.dart';
import 'package:pharmed_app/models/login_response_model.dart';
import 'package:pharmed_app/models/medical_profile_model.dart';
import 'package:pharmed_app/models/patient_profile_response_model.dart';
import 'package:pharmed_app/models/popular_medication_model.dart';
import 'package:pharmed_app/models/signup_otp_response_model.dart';
import 'package:pharmed_app/models/signup_response_model.dart';
import 'package:pharmed_app/models/suggestion_response_model.dart';
import 'package:pharmed_app/models/terms_and_conditions_model.dart';
import 'package:pharmed_app/models/thread_response_model.dart';
import 'package:pharmed_app/models/update_medication_response_model.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/authentication/login/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Login service
  Future<LoginResponse?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.baseurl + ApiConstants.login),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": email,
          "password": password,
        }),
      );

      print('Response Status Code : ${response.statusCode}');
      print('Response Data : ${response.body}');

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      rethrow;
    }
  }

  // Login otp service
  Future<LoginOtpResponse?> loginOtp(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.baseurl + ApiConstants.loginOtp),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": email,
          "otp": otp,
        }),
      );

      print('Response Status Code : ${response.statusCode}');
      print('Response Data : ${response.body}');

      if (response.statusCode == 200) {
        return LoginOtpResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception("Invalid OTP");
      } else {
        throw Exception("Failed to Login");
      }
    } catch (e) {
      rethrow;
    }
  }

  // sign up service
Future<dynamic> signUp(
    String userName, String email, String phoneNum, String password) async {
  try {
    final response = await http.post(
      Uri.parse(ApiConstants.baseurl + ApiConstants.signUp),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "username": userName,
        "email": email,
        "password": password,
        "phone": phoneNum,
      }),
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Data: ${response.body}');

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 201) {
      // Parse into model only when status is 201
      return SignUpResponse.fromJson(responseData);
    } else {
      // Pass raw message for other status codes
      final String message = responseData['data']?['issue']?[0]?['details']?['text'] ?? 'Unknown error';
      return message;
    }
  } catch (e) {
    rethrow;
  }
}

  // Login otp service
  Future<SignUpOtpResponse?> signUpOtp(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.baseurl + ApiConstants.loginOtp),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": email,
          "otp": otp,
        }),
      );

      print('Response Status Code : ${response.statusCode}');
      print('Response Data : ${response.body}');

      if (response.statusCode == 200) {
        return SignUpOtpResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception("Invalid OTP");
      } else {
        throw Exception("Failed to Login");
      }
    } catch (e) {
      rethrow;
    }
  }

  // Create patient profile service
 Future<PatientProfileResponse> createPatientProfile({
  required String name,
  required String dob,
  required String gender,
  required String nationality,
  required String weight,
  required String lang,
  required int term,
  required String phone,
  required String email,
  required String address,
  required String maritalStatus,
  required String birthPlace,
}) async {
  try {
    final url = ApiConstants.baseurl + ApiConstants.patientProfile;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('loggedInToken') ?? '';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        "name": name,
        "dob": dob,
        "gender": gender,
        "nationality": nationality,
        "weight": weight,
        "lang": lang,
        "term": term,
        "phone": phone,
        "email": email,
        "address": address,
        "marital_status": maritalStatus,
        "birth_place": birthPlace,
        "active": true
      }),
    );
    // print();

    print('Response Status Code : ${response.statusCode}');
    print('Response Data : ${response.body}');

    final Map<String, dynamic> jsonBody = json.decode(response.body);

    if (response.statusCode == 201) {
      return PatientProfileResponse.fromJson(jsonBody);
    } else if (response.statusCode == 422) {
      final firstError = jsonBody['errors']?.values?.first?[0] ?? 'Validation error';
      throw Exception(firstError);
    } else {
      throw Exception(jsonBody['message'] ?? 'Failed to create profile');
    }
  } catch (e) {
    throw Exception('An error occurred: $e');
  }
}

  Future<MedicalProfileResponse> createMedicalProfile({
    required String fullName,
    required String institute,
    required String field,
    required String gender,
    required List<File> certificates,
    required List<File> medicalLicenses,
  }) async {
    try {
      final url = Uri.parse(ApiConstants.baseurl + ApiConstants.medicalProfile);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('loggedInToken') ?? '';
      String? email = prefs.getString('email') ?? '';
      String? phone = prefs.getString('phone') ?? '';

      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';

      // Add text fields
      request.fields['full_name'] = fullName;
      request.fields['institute'] = institute;
      request.fields['field'] = field;
      request.fields['gender'] = gender;
      request.fields['email'] = email;
      request.fields['phone'] = phone;
      request.fields['status'] = '1';

      // Attach certificate files
      for (var file in certificates) {
        request.files.add(await http.MultipartFile.fromPath(
          'certificate[]', // Ensure this matches API key
          file.path,
        ));
      }

      // Attach medical license files
      for (var file in medicalLicenses) {
        request.files.add(await http.MultipartFile.fromPath(
          'medical_license[]', // Ensure this matches API key
          file.path,
        ));
      }

      // Send the request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.body}');

      if (response.statusCode == 201) {
        return MedicalProfileResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create medical profile');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  // Fetch Terms & Conditions service
  Future<TermsAndConditionModel?> fetchTermsAndConditions() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.baseurl + ApiConstants.termsCondition),
      );

      if (response.statusCode == 200) {
        return TermsAndConditionModel.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to load terms & conditions.");
      }
    } catch (e) {
      rethrow;
    }
  }

   Future deleteAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('loggedInToken') ?? '';
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.baseurl + ApiConstants.deleteAccount),
        headers: {"Content-Type": "application/json",'Authorization': 'Bearer ${token}',},
      );

      print('Response Status Code : ${response.statusCode}');
      print('Response Data : ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception("Failed to Delete Account");
      }
    } catch (e) {
     print(e);
    }
  }

   Future delAccOtpVerify(String otp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('loggedInToken') ?? '';
    print(ApiConstants.baseurl + ApiConstants.delAccOtpVerify);
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.baseurl + ApiConstants.delAccOtpVerify),
        headers: {"Content-Type": "application/json",'Authorization': 'Bearer ${token}'},
        body: json.encode({
          "otp": otp,
        }),
      );

      print('Response Status Code : ${response.statusCode}');
      print('Response Data : ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 404) {
        throw Exception("Invalid OTP");
      } else {
        throw Exception("Failed to Login");
      }
    } catch (e) {
      rethrow;
    }
  }

  // popular medication
  Future<PopularMedicationResponse?> popularMedication({pageNum}) async {
    final url = ApiConstants.baseurl + ApiConstants.popularMedication;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('loggedInToken') ?? '';
    try {
      final response = await http.get(
        Uri.parse('${url}?page=${pageNum}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}',
        },
      );

      print('Response StatusCode : ${response.statusCode}');
      print('Response Body : ${response.body}');

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        return PopularMedicationResponse.fromJson(jsonData);
      } else if(response.statusCode == 401){
           prefs.clear();
           Get.offAll(LoginView());
           return null;
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error fetching data: $e");
      return null;
    }
  }

  // search medication
  Future<SuggestionResponse?> searchMedication(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('loggedInToken') ?? '';
    try {
      final url = Uri.parse(
          "${ApiConstants.baseurl + ApiConstants.suggestion}?query=$query");
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return SuggestionResponse.fromJson(jsonData);
      }else if(response.statusCode == 401){
           prefs.clear();
           Get.offAll(LoginView());
           return null;
      } else {
        print("Error: ${response.statusCode}, ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception while fetching data: $e");
      return null;
    }
  }

  Future<List<dynamic>> searchMedicationInfo(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('loggedInToken') ?? '';

    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseurl}Medication/search?query=$query'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('Response Status Code : ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData is List) {
          return jsonData;
        } else if (jsonData is Map<String, dynamic>) {
          return [jsonData];
        }
      } else if (response.statusCode == 500) {
        print("Server error (500). Returning empty data.");
        return [];
      }else if(response.statusCode == 401){
           prefs.clear();
           Get.offAll(LoginView());
      } else {
        print("Error fetching medications: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }

    return [];
  }

  // add medication
 Future<AddMedication?> addMedication(Map<String, dynamic> data) async {
  final url = Uri.parse(ApiConstants.baseurl + ApiConstants.addMedication);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('loggedInToken') ?? '';

  try {
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );

    print('Response Status Code : ${response.statusCode}');
    print('Response Data : ${response.body}');

    final responseData = json.decode(response.body);

    if (response.statusCode == 201) {
      return AddMedication.fromJson(responseData);
    } else if (response.statusCode == 401) {
      prefs.clear();
      Get.offAll(LoginView());
      throw Exception('Unauthorized: Session expired');
    } else {
      throw Exception(responseData['message'] ?? 'Error: ${response.statusCode}');
    }
  } catch (error) {
    print("Error: $error");
    return null;
  }
}

  // get medication
Future<GetMedicationResponse> getMedications({required int page}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('loggedInToken') ?? '';
  final url = Uri.parse(ApiConstants.baseurl + ApiConstants.getMedication + '?page=$page');

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Response StatusCode: ${response.statusCode}');
    print('Response Data: ${response.body}');

    final jsonData = json.decode(response.body);

    if (response.statusCode == 200) {
      return GetMedicationResponse.fromJson(jsonData);
    } else if (response.statusCode == 401) {
      prefs.clear();
      Get.offAll(LoginView());
      throw Exception('Unauthorized: Session expired');
    } else {
      throw Exception(jsonData['message'] ?? 'Failed to load medications');
    }
  } catch (e) {
    throw Exception('Error fetching medications: $e');
  }
}


Future<UpdateMedicationResponse?> updateMedication(Map<String, dynamic> data, String id) async {
  final url = '${ApiConstants.baseurl + ApiConstants.updateMedication}/$id';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('loggedInToken') ?? '';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return UpdateMedicationResponse.fromJson(responseData);
    } else if (response.statusCode == 401) {
      prefs.clear();
      Get.offAll(LoginView());
      throw Exception('Unauthorized: Session expired');
    } else {
      print('Error Response: ${response.body}');
      return null;
    }
  } catch (error) {
    print("Exception: $error");
    return null;
  }
}

  Future<DrugInteractionResponse?> drugInteraction(List<String> drugs) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('loggedInToken') ?? '';

    // Convert drugs list to query parameter string
    String queryString = drugs.map((drug) => "drugs[]=$drug").join("&");

    try {
      var response = await http.get(
        Uri.parse(
            "${ApiConstants.baseurl}${ApiConstants.checkDrugInteraction}?$queryString"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      print('Response Status Code : ${response.statusCode}');
      print('Response Body : ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return DrugInteractionResponse.fromJson(data);
      }else if(response.statusCode == 401){
           prefs.clear();
           Get.offAll(LoginView());
           throw Exception('Unauthorized: Session expired');
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // notification
  Future<Map<String, dynamic>?> medicineNotification(selectedDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('loggedInToken') ?? '';

    final url =
        "${ApiConstants.baseurl}${ApiConstants.notification}notification?query=$selectedDate";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      print(url);
      print(token);
      print('Response Status Code : ${response.statusCode}');
      print('Response Body : ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }else if(response.statusCode == 401){
           prefs.clear();
           Get.offAll(LoginView());
           throw Exception('Unauthorized: Session expired');
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  Future<GetThreadResponse> getThread(String medicine, int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('loggedInToken') ?? '';
    final url = Uri.parse(
        '${ApiConstants.baseurl}${ApiConstants.getThread}get?medicine=$medicine&page=$page');

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      print('Response Body : ${response.body}');

      if (response.statusCode == 200) {
        return GetThreadResponse.fromJson(json.decode(response.body));
      }else if(response.statusCode == 401){
           prefs.clear();
           Get.offAll(LoginView());
           throw Exception('Unauthorized: Session expired');
      } else {
        throw Exception('Failed to load thread: ${response.body}');
      }
    } catch (e) {
      print('Error in getThread: $e');
      rethrow;
    }
  }

  Future<AddThreadResponse> addThread(String medicine, String comment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('loggedInToken') ?? '';
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseurl}${ApiConstants.addThread}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'medicine': medicine,
          'comments': comment,
        }),
      );

      print('Response Status Code : ${response.statusCode}');
      print('Response Body : ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return AddThreadResponse.fromJson(responseBody);
      }else if(response.statusCode == 401){
           prefs.clear();
           Get.offAll(LoginView());
           throw Exception('Unauthorized: Session expired');
      } else {
        throw Exception('Failed to add thread: ${response.body}');
      }
    } catch (e) {
      print('Error adding thread: $e'); // Log error details
      throw Exception('Error adding thread data: $e');
    }
  }

  Future<http.Response> translateText(String text, String targetLang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('loggedInToken') ?? '';
    try {
      final response = await http.post(
        Uri.parse("http://64.111.99.56/translate"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "data": {"text": text},
          "target_lang": targetLang,
        }),
      );
      return response;
    } catch (e) {
      print("Error calling translation API: $e");
      throw Exception("Failed to call translation API");
    }
  }
}
