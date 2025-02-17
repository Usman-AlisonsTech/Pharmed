import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WhoAreYouController extends GetxController {
  var selectedRole = RxString('');

  // Method to update the selected role
  void setSelectedRole(String role) {
    selectedRole.value = role;
  }

  Future<void> saveToken(String? token, String? userName, int? id) async {
    if (token != null && token.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('loggedInToken', token);
      prefs.setString('username', userName ?? '');
      prefs.setInt('id', id ?? 0);
      print("Token saved: $token");
      print("User Name saved: $userName");
    }
  }
}
