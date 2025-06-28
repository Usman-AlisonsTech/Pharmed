import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/connect_phar/connect_phar_view.dart';
import 'package:pharmed_app/views/home/home_controller.dart';
import 'package:pharmed_app/views/search/medicine_information/medicine_information_controller.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'package:pharmed_app/widgets/custom_textfield.dart';

class MedicineInformationView extends StatefulWidget {
  final String medicineName;
  final List<dynamic> jsonData;
  final RxBool isLoading;

  const MedicineInformationView({
    super.key,
    required this.jsonData,
    required this.medicineName,
    required this.isLoading,
  });

  @override
  State<MedicineInformationView> createState() => _MedicineInformationViewState();
}

class _MedicineInformationViewState extends State<MedicineInformationView>
    with SingleTickerProviderStateMixin {
  final RxList<dynamic> savedData = <dynamic>[].obs;
  final homeController = Get.find<HomeController>();
  final controller = Get.put(MedicineInformationController());
  List<dynamic> localJsonData = [];
  final RxMap<String, String> translations = <String, String>{}.obs;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    localJsonData = List.from(widget.jsonData);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        controller.text =
            "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    savedData.clear();

    return Scaffold(
      body: Obx(() {
        if (homeController.isSearchLoading.value || widget.isLoading.value) {
          return const Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(
          left: ScreenConstants.screenhorizontalPadding,
          right: ScreenConstants.screenhorizontalPadding,
          top: screenHeight * 0.055,
        ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FutureBuilder<String>(
                          future: controller.translateText(widget.medicineName),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox();
                            } else if (snapshot.hasError) {
                              return Text(
                                widget.medicineName,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.07,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Poppins',
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              );
                            } else {
                              return Text(
                                snapshot.data ?? widget.medicineName,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.07,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Poppins',
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              );
                            }
                          },
                        ),
                      ),
                      if (widget.jsonData.length != 1 ||
                          widget.jsonData[0]["message"] != "No Search History")
                        GestureDetector(
                          onTap: () {
                            Get.to(ConnectPharView(
                              medicineName: widget.medicineName,
                            ));
                          },
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: screenWidth * 0.2,
                              maxWidth: screenWidth * 0.3,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/chat.svg',
                                  color: Colors.white,
                                  width: 16,
                                  height: 16,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'connect_phar'.tr,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.visible,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: ColorConstants.themecolor,
                    labelStyle: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                    tabs: const [
                      Tab(text: 'Uses'),
                      Tab(text: 'Side Effects'),
                      Tab(text: 'Precautions'),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  SizedBox(
                    height: screenHeight * 0.6,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _buildWidgets(widget.jsonData),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Side Effects',
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Precautions',
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
      bottomNavigationBar: (widget.jsonData.length == 1 &&
              widget.jsonData[0]["message"] == "No Search History")
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, bottom: 20, top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonButton(
                    onPressed: () {
                      if (widget.jsonData.length == 1 &&
                          widget.jsonData[0]["message"] == "No Search History") {
                        return;
                      } else {
                        _showBottomSheet(context, widget.medicineName);
                      }
                    },
                    title: 'add_to_medicines'.tr,
                    bgColor: Colors.black,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Source: FDA –',
                        fontSize: 12, 
                        weight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                      CustomText(
                        text: 'https://api.fda.gov',
                        fontSize: 12, 
                        color: ColorConstants.themecolor,
                        weight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  List<Widget> _buildWidgets(dynamic data,
      {String? heading, bool isSubKey = false}) {
    List<Widget> widgets = [];

    // If the heading is not 'medications' and it's not null, translate the heading
    if (heading != null && heading.toLowerCase() != 'medications') {
      String formattedHeading = heading.replaceAll('_', ' ').capitalize!;

      // Translate the heading
      widgets.add(FutureBuilder<String>(
        future: controller.translateText(formattedHeading),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          } else if (snapshot.hasError) {
            return Text(
              formattedHeading,
              style: TextStyle(
                fontSize: isSubKey ? 15 : 22,
                fontWeight: isSubKey ? FontWeight.w700 : FontWeight.w800,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            );
          } else {
            return Text(
              snapshot.data ?? formattedHeading,
              style: TextStyle(
                fontSize: isSubKey ? 15 : 22,
                fontWeight: isSubKey ? FontWeight.w700 : FontWeight.w800,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            );
          }
        },
      ));

      savedData.add('$formattedHeading :');
      widgets.add(SizedBox(height: 5));
    }

    if (data is Map<String, dynamic>) {
      data.forEach((key, value) {
        if (key.toLowerCase() == 'id' || key.toLowerCase() == 'route') return;
        widgets.addAll(_buildWidgets(value, heading: key, isSubKey: true));
      });
    } else if (data is List) {
      for (var item in data) {
        widgets.addAll(_buildWidgets(item, isSubKey: true));
      }
    } else {
      savedData.add(data);

      widgets.add(FutureBuilder<String>(
        future: controller.translateText(data.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          } else if (snapshot.hasError) {
            return Text(
              data.toString(),
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot.data ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            );
          }
        },
      ));
    }

    widgets.add(SizedBox(height: 10));
    return widgets;
  }

  void _showBottomSheet(BuildContext context, medicineName) {
    final controller = Get.find<MedicineInformationController>();
    final _formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      isDismissible: false,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: screenHeight * 0.95,
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      controller.dateFields.clear();
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5)),
                      width: 30,
                      height: 30,
                      child: Center(
                        child: CustomText(
                          text: 'X',
                          weight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<String>(
                          future: controller.translateText(widget.medicineName),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: SizedBox(),
                              );
                            } else if (snapshot.hasError) {
                              return Text(
                                widget.medicineName,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Poppins',
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              );
                            } else {
                              return Text(
                                snapshot.data ?? widget.medicineName,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Poppins',
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              );
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        CustomText(text: 'prescribing_physician_name'.tr),
                        SizedBox(height: 10),
                        CustomTextField(
                          controller: controller.physicianName,
                          hintText: 'enter_physician_name'.tr,
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey),
                          borderColor: Color(0xffDADADA),
                          borderRadius: 8,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        // Dosage and Frequency Row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: 'dosage'.tr),
                                  SizedBox(height: 8),
                                  CustomTextField(
                                    hintText: 'eg_500'.tr,
                                    controller: controller.dosageController,
                                    hintStyle: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                    borderColor: Color(0xffDADADA),
                                    borderRadius: 8,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'This field is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: 'frequency'.tr),
                                  SizedBox(height: 8),
                                  CustomTextField(
                                    controller: controller.frequencyController,
                                    hintText: 'eg_twice_daily'.tr,
                                    borderColor: Color(0xffDADADA),
                                    hintStyle: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                    borderRadius: 8,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'This field is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        CustomText(text: 'reason_for_use'.tr),
                        SizedBox(height: 10),
                        CustomTextField(
                          controller: controller.reasonController,
                          hintText: 'condition_or_symptom'.tr,
                          borderColor: Color(0xffDADADA),
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey),
                          borderRadius: 8,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                          Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: 'start_date'.tr),
                                  SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () => _selectDate(context,
                                        controller.startDateController),
                                    child: AbsorbPointer(
                                      child: CustomTextField(
                                        controller:
                                            controller.startDateController,
                                        hintText: 'enter_start_date'.tr,
                                        borderColor: Color(0xffDADADA),
                                        hintStyle: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                        borderRadius: 8,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: 'end_date'.tr),
                                  SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () => _selectDate(
                                        context, controller.endDateController),
                                    child: AbsorbPointer(
                                      child: CustomTextField(
                                        controller:
                                            controller.endDateController,
                                        hintText: 'enter_end_date'.tr,
                                        hintStyle: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                        borderColor: Color(0xffDADADA),
                                        borderRadius: 8,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        CustomText(text: 'schedule_your_doses'.tr),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (controller.dateFields.isEmpty) {
                                        controller.addDateField();
                                      }
                                      controller.selectDateTime(0);
                                    },
                                    child: AbsorbPointer(
                                      child: Obx(() => CustomTextField(
                                            hintText: 'set_your_date'.tr,
                                            borderColor: Color(0xffDADADA),
                                            controller: TextEditingController(
                                                text: controller
                                                        .dateFields.isNotEmpty
                                                    ? controller
                                                        .dateFields[0].value
                                                    : ""),
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                            suffixIcon: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Icon(
                                                  Icons.watch_later_rounded,
                                                  color: Colors.grey),
                                            ),
                                            borderRadius: 8,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    controller.addDateField();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey),
                                      color: Color(0xffF9F9F9),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Center(
                                      child:
                                          Icon(Icons.add, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Dynamically Render Additional Fields
                            Obx(() {
                              return Column(
                                children: List.generate(
                                    controller.dateFields.length, (index) {
                                  if (index == 0) return SizedBox();

                                  return Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.selectDateTime(index);
                                            },
                                            child: AbsorbPointer(
                                              child: Obx(() => CustomTextField(
                                                    hintText:
                                                        'set_your_date'.tr,
                                                    borderColor:
                                                        Color(0xffDADADA),
                                                    controller:
                                                        TextEditingController(
                                                            text: controller
                                                                .dateFields[
                                                                    index]
                                                                .value),
                                                    hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey),
                                                    suffixIcon: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: Icon(
                                                          Icons
                                                              .watch_later_rounded,
                                                          color: Colors.grey),
                                                    ),
                                                    borderRadius: 8,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 5),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value
                                                              .trim()
                                                              .isEmpty) {
                                                        return 'This field is required';
                                                      }
                                                      return null;
                                                    },
                                                  )),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {
                                            controller.removeDateField(index);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.grey),
                                              color: Color(0xffF9F9F9),
                                            ),
                                            padding: EdgeInsets.all(10),
                                            child: Center(
                                              child: Icon(Icons.delete,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              );
                            }),
                            SizedBox(height: 20),
                            Obx(() => CommonButton(
                    title: 'add_to_medicines'.tr,
                    bgColor: Colors.black,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.addToMedicines(widget.medicineName, context);
                      }
                    },
                    isLoading: controller.isAddToMedicinesLoading.value,
                    borderRadius: 8,
                    fontSize: 16,
                  ),
                ),
                          ],
                        ),

                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              // Fixed bottom button
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: screenWidth * 0.1, vertical: 20),
              //   child: Obx(
              //     () => CommonButton(
              //       title: 'add_to_medicines'.tr,
              //       bgColor: Colors.black,
              //       onPressed: () {
              //         if (_formKey.currentState!.validate()) {
              //           controller.addToMedicines(widget.medicineName, context);
              //         }
              //       },
              //       isLoading: controller.isAddToMedicinesLoading.value,
              //       borderRadius: 8,
              //       fontSize: 16,
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
