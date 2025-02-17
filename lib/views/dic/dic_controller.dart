import 'package:get/get.dart';
import 'package:pharmed_app/models/drug_interaction_response_model.dart';
import 'package:pharmed_app/service/api_service.dart';

class DicController extends GetxController {
  RxBool showInterAction = false.obs;
  RxBool isLoading = false.obs;
  Rx<DrugInteractionResponse?> interactionResponse = Rx<DrugInteractionResponse?>(null);
  ApiService apiService = ApiService();

  Future<void> checkDrugInteraction(String drugInput) async {
    isLoading.value = true;
    List<String> drugs = drugInput.split(',').map((e) => e.trim()).toList();

    try {
      final result = await apiService.drugInteraction(drugs);
      if (result != null) {
        interactionResponse.value = result;
        showInterAction.value = true;
      } else {
        Get.snackbar("Error", "Failed to fetch interactions");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
