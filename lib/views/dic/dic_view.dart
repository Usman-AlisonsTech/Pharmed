import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/details/drugs_detail_view.dart';
import 'package:pharmed_app/views/dic/dic_controller.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_appbar.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'package:pharmed_app/widgets/nav_item.dart';

class DicView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController drugController = TextEditingController();
  final RxList<String> addedDrugs =
      <String>[].obs; // List to store added medicines

  DicView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DicController());
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(height: screenHeight * 0.1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState?.closeDrawer();
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            left: screenWidth * 0.05,
                            right: screenWidth * 0.05),
                        child: Icon(
                          Icons.arrow_back,
                          size: 22,
                        ))),
              ],
            ),
            SizedBox(height: screenHeight * 0.05),
            buildDrawerItem(
              screenWidth,
              screenHeight,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenConstants.screenhorizontalPadding,
              vertical: screenHeight * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(scaffoldKey: scaffoldKey),
              SizedBox(height: screenHeight * 0.065),
              CustomText(
                  text: 'drug_interaction_checker'.tr,
                  fontSize: 30,
                  weight: FontWeight.w900),
              SizedBox(height: screenHeight * 0.03),
              CustomText(
                  text: 'add_drug_to_check'.tr,
                  fontSize: 16,
                  weight: FontWeight.w500),
              SizedBox(height: screenHeight * 0.03),
              Obx(() => Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...addedDrugs.map((drug) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Container(
                                      child: Chip(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        label: Text(drug),
                                        deleteIcon: Icon(Icons.close, size: 16),
                                        onDeleted: () {
                                          addedDrugs.remove(drug);
                                        },
                                        labelPadding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 0),
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                SizedBox(
                                  width: 200,
                                  child: TextField(
                                    controller: drugController,
                                    style: TextStyle(
                                        fontSize: 16, fontFamily: 'Poppins'),
                                    decoration: InputDecoration(
                                        hintText: addedDrugs.isEmpty
                                            ? 'add_medicine_name'.tr
                                            : '',
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontFamily: 'Poppins')),
                                    onSubmitted: (value) {
                                      String drugName = value.trim();
                                      if (drugName.isNotEmpty &&
                                          !addedDrugs.contains(drugName)) {
                                        addedDrugs.add(drugName);
                                      }
                                      drugController.clear();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 10),
              Row(
                children: [
                  Spacer(),
                  CustomText(
                    text: 'add_at_least'.tr,
                    fontSize: 12,
                    weight: FontWeight.w500,
                    color: ColorConstants.themecolor,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.07),
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      onPressed: () {
                        if (addedDrugs.isNotEmpty) {
                          controller
                              .checkDrugInteraction(addedDrugs.join(", "));
                        } else {
                          Get.snackbar("Error", "Please enter drug names",
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        }
                      },
                      title: 'check_interaction'.tr,
                      fontFamily: 'Poppins',
                      bgColor: ColorConstants.buttoncolor,
                      textWeight: FontWeight.w600,
                      borderColor: ColorConstants.themecolor,
                      verticalPadding: 12,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: screenWidth * 0.3,
                    child: CommonButton(
                      onPressed: () {
                        drugController.clear();
                        addedDrugs.clear();
                        controller.showInterAction.value = false;
                        controller.interactionResponse.value = null;
                      },
                      title: 'clear'.tr,
                      textWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      horizontalPadding: 10,
                      verticalPadding: 12,
                      bgColor: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (controller.showInterAction.value) {
                  if (controller.interactionResponse.value == null ||
                      controller
                          .interactionResponse.value!.interactions.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
                            child: CustomText(
                                text: 'No interactions found.',
                                fontSize: 16,
                                weight: FontWeight.w500),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: 'interaction_found'.tr,
                                fontSize: 16,
                                weight: FontWeight.w900),
                            CustomText(
                              text:
                                  '${controller.interactionResponse.value!.totalInteractions ?? 0}',
                              weight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        ...controller.interactionResponse.value!.interactions
                            .asMap()
                            .entries
                            .map((entry) {
                          int index = entry.key + 1;
                          final interaction = entry.value;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(color: Color(0xffEEEEEE)),
                              ListTile(
                                onTap: () {
                                  Get.to(DrugsDetailView(
                                      interaction: interaction));
                                },
                                minTileHeight: 5,
                                title: CustomText(
                                    text: 'interaction_details'.tr + '$index',
                                    fontSize: 16,
                                    weight: FontWeight.w500),
                                trailing: Icon(Icons.arrow_forward, size: 20),
                              ),
                              Divider(color: Color(0xffEEEEEE)),
                            ],
                          );
                        }).toList(),
                      ],
                    );
                  }
                } else {
                  return SizedBox.shrink();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
