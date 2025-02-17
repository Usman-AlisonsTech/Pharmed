import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: screenHeight * 0.08,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () => Get.back(), child: Icon(Icons.arrow_back)),
                  SizedBox(width: 15),
                  Expanded(
                      child: SizedBox(
                    height: 35,
                    child: TextFormField(
                      controller: controller.searchController,
                      textAlign: TextAlign.center,
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.black,
                            size: 16,
                          ),
                          onPressed: () {
                            controller.clearSearchField();
                          },
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
                        controller
                            .searchMedication(controller.searchController.text);
                      },
                    ),
                  )),
                ],
              ),
              // Show search results dynamically
              Obx(() {
                if (controller.isSearchLoading.value) {
                  return Container(
                    margin: EdgeInsets.only(top: 50),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(strokeWidth: 3),
                    ),
                  );
                } else if (controller.searchResults.isEmpty &&
                    controller.searchController.text.isNotEmpty) {
                  return Container(
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
                  return SizedBox(); // Hide the UI when the text field is empty
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.searchResults.length,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final suggestion = controller.searchResults[index];
                      return ListTile(
                        title: CustomText(
                            text: suggestion.genericName ?? 'Unknown'),
                        onTap: () {
                          controller.searchController.text != ''
                              ? controller.searchMedicationInfo(
                                  suggestion.genericName.toString(),
                                  suggestion.genericName ?? '')
                              : null;
                        },
                        trailing:
                            SvgPicture.asset('assets/svg/search_icon.svg'),
                      );
                    },
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
