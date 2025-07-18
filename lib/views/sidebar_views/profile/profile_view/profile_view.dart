import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/sidebar_views/profile/profile_view/profile_controller.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_text.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      body: Obx(() { 
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = controller.profileData.value?.data;
        final name = profile?.name.isNotEmpty == true ? profile!.name[0].text : 'N/A';
        final email = profile?.telecom.firstWhereOrNull((t) => t.system == 'email')?.value ?? 'N/A';
        final gender = profile?.gender ?? 'N/A';
        final maritalStatus = profile?.maritalStatus?.text ?? 'N/A';
        final address = profile?.address.isNotEmpty == true ? profile!.address[0].text : 'N/A';
        final weight = profile?.extension.firstWhereOrNull(
              (e) => e.url!.contains('StructureDefinition/weight'),
            )?.valueString ?? 'N/A';
        final nationality = profile?.extension.firstWhereOrNull(
              (e) => e.url!.contains('StructureDefinition/nationality'),
            )?.valueString ?? 'N/A';
        final birthPlace = profile?.extension.firstWhereOrNull(
              (e) => e.url!.contains('StructureDefinition/birthPlace'),
            )?.valueString ?? 'N/A';
        return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: ScreenConstants.screenhorizontalPadding,
            right: ScreenConstants.screenhorizontalPadding,
            top: screenHeight * 0.055,
            bottom: screenHeight * 0.055,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.arrow_back, size: 22),
              ),
              SizedBox(height: screenHeight * 0.04),
              CustomText(
                text: 'profile_information_card'.tr,
                weight: FontWeight.w900,
                fontSize: 30,
              ),
              SizedBox(height: screenHeight * 0.04),
              // Display full name from controller
              CustomText(
                text: controller.profileData.value?.data?.name.first.text ?? '',
                weight: FontWeight.w700,
                fontSize: 28,
                color: ColorConstants.themecolor,
              ),
              SizedBox(height: screenHeight * 0.03),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffF9F9F9),
                ),
                padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                child: controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                      rowText('Full Name', name??''),
                      rowText('Email', email),
                      rowText('Gender', gender.capitalizeFirst ?? gender),
                      rowText('Marital Status', maritalStatus.capitalizeFirst ?? maritalStatus),
                      rowText('Address', address??''),
                      rowText('Weight', weight),
                      rowText('Nationality', nationality),
                      rowText('City', birthPlace),
                        ],
                      ),
              ),
              SizedBox(height: screenHeight * 0.04),
              CommonButton(
                onPressed: () {
                },
                title: 'edit_profile'.tr,
                bgColor: Colors.black,
                icon: const Icon(Icons.arrow_forward_rounded, color: Colors.white),
              ),
            ],
          ),
        ),
      );}),
    );
  }

  Widget rowText(String key, String value) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Expanded(
          child: Text(
            key,
           style: TextStyle(
               fontWeight: FontWeight.w500,
                fontFamily: 'Poppins'
           ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Text(
           value,
            style: TextStyle(
               fontWeight: FontWeight.w500,
               fontFamily: 'Poppins'
           ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
        ),
        ],
      ),
    );
  }
}
