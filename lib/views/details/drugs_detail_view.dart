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
              SizedBox(height: screenHeight * 0.03),
  
              Container(
                width: double.infinity,
                child: Obx(() => CustomText(
                      textAlign: TextAlign.center,
                      text: controller.translatedDrugNames.value,
                      fontSize: 20,
                      weight: FontWeight.w500,
                    )),
              ),

              SizedBox(height: screenHeight * 0.04),
              CustomText(
                text: 'overview'.tr,
                fontSize: 16,
                weight: FontWeight.w900,
              ),
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
              SizedBox(height: screenHeight * 0.03),
              CustomText(
                text: 'security_levels'.tr,
                fontSize: 16,
                weight: FontWeight.w900,
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xffF3E632)),
                  color: Color(0xffFFFDE7),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: '45', weight: FontWeight.w600,fontSize: 20),
                        CustomText(text: 'low risk', weight: FontWeight.w400,fontSize: 15),
                      ],
                    ),
                    CircleAvatar(backgroundColor:Color(0xffF3E632),child: Icon(Icons.dangerous, color: Colors.white,),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
