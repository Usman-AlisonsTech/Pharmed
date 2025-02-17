import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/models/drug_interaction_response_model.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/details/drugs_detail_controller.dart';
import 'package:pharmed_app/widgets/custom_text.dart';

class DrugsDetailView extends StatelessWidget {
  final Interaction interaction;
  const DrugsDetailView({super.key, required this.interaction});

  @override
  Widget build(BuildContext context) {
    final DrugsDetailController controller = Get.put(DrugsDetailController());

    // Fetch translations when view is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchTranslations(interaction.interactionDetails);
      controller.fetchDrugNameTranslations(interaction.drugs);
    });

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: ScreenConstants.screenhorizontalPadding,
            right: ScreenConstants.screenhorizontalPadding,
            top: screenHeight * 0.08,
            bottom: screenHeight * 0.09,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back, size: 25),
              ),
              SizedBox(height: screenHeight * 0.05),
              CustomText(
                text: 'interaction_details'.tr,
                fontSize: 30,
                weight: FontWeight.w900,
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  CustomText(
                    text: "drugs".tr,
                    fontSize: 18,
                    weight: FontWeight.w700,
                  ),
                  SizedBox(width: 10),
                  Obx(() => CustomText(
                        text: controller.translatedDrugNames.value,
                        fontSize: 18,
                        weight: FontWeight.w700,
                      )),
                ],
              ),

              // Show translated drug names

              SizedBox(height: screenHeight * 0.01),

              // Show translated details
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: controller.translatedDetails.map((detail) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: CustomText(
                          text: detail,
                          fontSize: 14,
                          weight: FontWeight.w400,
                          color: Colors.grey[700],
                        ),
                      );
                    }).toList(),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
