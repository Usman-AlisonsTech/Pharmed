import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'search_controller.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final controller = Get.put(SearchScreenController());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: ScreenConstants.screenhorizontalPadding,
          right: ScreenConstants.screenhorizontalPadding,
          top: screenHeight * 0.055,
        ),
        child: Column(
          children: [
            // Fixed Search Bar Section
            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(Icons.arrow_back),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: SizedBox(
                    height: 37,
                    child: TextFormField(
                      controller: controller.searchController,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: 'search'.tr,
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: GestureDetector(
                          onTap: () {
                            controller.searchMedication(
                                controller.searchController.text);
                          },
                          child: Icon(
                            Icons.search,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      onChanged: (value) {
                        controller.searchMedication(
                            controller.searchController.text);
                      },
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isSearchLoading.value) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(strokeWidth: 3),
                      ),
                    ),
                  );
                } else if (controller.searchResults.isEmpty &&
                    controller.searchController.text.isNotEmpty) {
                  return Container(
                    color: Color(0xffF9F9F9),
                    margin: EdgeInsets.only(top: 20),
                    child: ListTile(
                      title: CustomText(text: controller.searchController.text),
                      onTap: () {
                        controller.searchMedicationInfo(
                            controller.searchController.text,
                            controller.searchController.text);
                      },
                      trailing: SvgPicture.asset('assets/svg/search_icon.svg'),
                    ),
                  );
                } else if (controller.searchController.text.isEmpty) {
                  return SizedBox();
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 10),
                    itemCount: controller.searchResults.length,
                    itemBuilder: (context, index) {
                      final suggestion = controller.searchResults[index];
                      return Container(
                        color: Color(0xffF9F9F9),
                        margin: EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            controller.searchController.text != ''
                                ? controller.searchMedicationInfo(
                                    suggestion.genericName.toString(),
                                    suggestion.genericName ?? '',
                                  )
                                : null;
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text:
                                            suggestion.genericName ?? 'Unknown',
                                        fontSize: 14,
                                        weight: FontWeight.w500,
                                      ),
                                      SizedBox(height: 4),
                                      CustomText(
                                        text: suggestion.genericName ?? 'Unknown',
                                        fontSize: 13,
                                        weight: FontWeight.w500,
                                        color: Color(0xffB1B1B1),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                SvgPicture.asset('assets/svg/search_icon.svg'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}