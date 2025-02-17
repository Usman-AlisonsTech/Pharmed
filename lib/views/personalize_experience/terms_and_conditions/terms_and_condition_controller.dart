import 'package:get/get.dart';
import 'package:pharmed_app/service/api_service.dart';

class TermsAndConditionController extends GetxController {
  final ApiService apiService = ApiService();
  var isLoading = true.obs;
  var termsHtml = ''.obs;
  var isButtonVisible = true.obs;

  @override
  void onInit() {
    fetchTermsAndConditions();
    super.onInit();
  }

  Future<void> fetchTermsAndConditions() async {
    try {
      final termsData = await apiService.fetchTermsAndConditions();
      termsHtml.value = termsData?.data?.content ?? 'No terms available.';
    } catch (e) {
      termsHtml.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }

  // Function to hide the button after scroll
  void hideButton() {
    isButtonVisible.value = false;
  }
}
