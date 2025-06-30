import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/details/drugs_detail_view.dart';
import 'package:pharmed_app/views/dic/dic_controller.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_appbar.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'package:pharmed_app/widgets/nav_item.dart';
import 'dart:async';

class DicView extends StatefulWidget {
  const DicView({super.key});

  @override
  State<DicView> createState() => _DicViewState();
}

class _DicViewState extends State<DicView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchController = TextEditingController();
  final RxList<String> addedDrugs = <String>[].obs;
  Timer? _debounce;
  final FocusNode _focusNode = FocusNode();
  bool _showDropdown = false;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    setState(() {
      _showDropdown = _focusNode.hasFocus && searchController.text.isNotEmpty;
    });
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchController.text.isNotEmpty) {
        Get.find<DicController>().searchMedication(searchController.text);
        setState(() {
          _showDropdown = true;
        });
      } else {
        setState(() {
          _showDropdown = false;
        });
        Get.find<DicController>().searchResults.clear();
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

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
               Row(
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
                    CustomText(
                      text: 'setting'.tr,
                      weight: FontWeight.w900,
                      fontSize: 30,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            buildDrawerItem(screenWidth, screenHeight, context),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenConstants.screenhorizontalPadding,
              vertical: screenHeight * 0.055),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(scaffoldKey: scaffoldKey),
              SizedBox(height: screenHeight * 0.04),
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xffF9F9F9),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    // Search TextField
                    TextField(
                      controller: searchController,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        hintText: 'add_medicine_name'.tr,
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      onSubmitted: (value) {
                        String drugName = value.trim();
                        if (drugName.isNotEmpty &&
                            !addedDrugs.contains(drugName)) {
                          addedDrugs.add(drugName);
                          searchController.clear();
                          setState(() {
                            _showDropdown = false;
                          });
                          controller.searchResults.clear();
                        }
                      },
                    ),
                    // Search results dropdown
                    Obx(() {
                      if (controller.isSearchLoading.value) {
                        return Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 3),
                          ),
                        );
                      } else if (_showDropdown &&
                          controller.searchResults.isEmpty &&
                          searchController.text.isNotEmpty) {
                        return Container(
                          color: Color(0xffF9F9F9),
                          margin: EdgeInsets.only(top: 0),
                          child: ListTile(
                            tileColor: Colors.red,
                            title: CustomText(text: searchController.text),
                            trailing: CircleAvatar(
                              backgroundColor: ColorConstants.themecolor,
                              child: Icon(Icons.add,
                                  size: 16, color: Colors.white),
                              radius: 10,
                            ),
                            onTap: () {
                              String drugName = searchController.text;
                              if (drugName.isNotEmpty &&
                                  !addedDrugs.contains(drugName)) {
                                addedDrugs.add(drugName);
                                searchController.clear();
                                setState(() {
                                  _showDropdown = false;
                                });
                                controller.searchResults.clear();
                              }
                            },
                          ),
                        );
                      } else if (_showDropdown && controller.searchResults.isNotEmpty) {
  return Container(
    constraints: BoxConstraints(maxHeight: 200),
    margin: EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
      color: Color(0xffF9F9F9),
    ),
    child: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.searchResults.length,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final suggestion = controller.searchResults[index];
          return ListTile(
            title: CustomText(text: suggestion.genericName ?? 'Unknown'),
            minTileHeight: 50,
            trailing: CircleAvatar(
              backgroundColor: ColorConstants.themecolor,
              child: Icon(Icons.add, size: 16, color: Colors.white),
              radius: 10,
            ),
            onTap: () {
              String drugName = suggestion.genericName ?? '';
              if (drugName.isNotEmpty && !addedDrugs.contains(drugName)) {
                addedDrugs.add(drugName);
                searchController.clear();
                setState(() {
                  _showDropdown = false;
                });
                controller.searchResults.clear();
              }
            },
          );
        },
      ),
    ),
  );
}

                      return SizedBox();
                    }),
                  ],
                ),
              ),
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
              SizedBox(height: 15),
              Obx(() => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: addedDrugs
                        .map((drug) => Chip(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Color(0xffF9F9F9)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              label: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 2.0),
                                child: Text(
                                  drug,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              deleteIcon: CircleAvatar(
                                backgroundColor: ColorConstants.themecolor,
                                child: Icon(Icons.remove,
                                    size: 16, color: Colors.white),
                                radius: 10,
                              ),
                              onDeleted: () {
                                addedDrugs.remove(drug);
                              },
                              labelPadding: EdgeInsets.symmetric(horizontal: 0),
                              backgroundColor: Color(0xffF9F9F9),
                              deleteIconColor: Colors.white,
                            ))
                        .toList(),
                  )),
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
                        searchController.clear();
                        addedDrugs.clear();
                        controller.showInterAction.value = false;
                        controller.interactionResponse.value = null;
                        controller.searchResults.clear();
                        controller.isLoading.value = false;
                        setState(() {
                          _showDropdown = false;
                        });
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
                  return Center(
                      child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator()));
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
                        SizedBox(height: 10),
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
                                    text: 'interaction_details'.tr + ' $index',
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
