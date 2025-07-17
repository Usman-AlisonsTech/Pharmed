import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/models/popular_medication_model.dart';
import 'package:pharmed_app/views/home/home_controller.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'package:pharmed_app/widgets/custom_textfield.dart';

class MedicineContainer extends StatefulWidget {
  final Datum data;
  const MedicineContainer({super.key, required this.data});

  @override
  State<MedicineContainer> createState() => _MedicineContainerState();
}

class _MedicineContainerState extends State<MedicineContainer> {
  final HomeController controller = Get.find<HomeController>();
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
  void initState() {
    super.initState();
    controller.fetchMedicineTranslations([widget.data.name ?? '']);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        controller.searchMedication(
            widget.data.name ?? '', widget.data.name ?? '');
      },
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: Offset(2, 2),
              blurRadius: 1,
              spreadRadius: 0.2,
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              offset: Offset(-2, -2),
              blurRadius: 1,
              spreadRadius: 0.2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenWidth * 0.8,
              height: screenWidth * 0.33,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                    imageUrl: widget.data.imgPath ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error)),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Obx(() {
                        String translatedName = controller.translatedMedicines[widget.data.name] ?? 
                        widget.data.name ?? 
                        'Unknown Medicine';    
                        return Text(
                          translatedName,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                          maxLines: 2, 
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    controller.dateFields.clear();
                    String displayName = controller.translatedMedicines[widget.data.name] ?? 
                      widget.data.name ?? 
                     'Unknown Medicine';
                    _showBottomSheet(context, widget.data, displayName);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    child: Center(
                      child: CustomText(
                        text: 'add_to_medicines'.tr,
                        fontSize: screenWidth * 0.027,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, Datum data, medicineName) {
  final HomeController controller = Get.find<HomeController>();
  final _formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    isDismissible: false,
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;

      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: screenHeight * 0.95,
          child: Column(
            children: [
              // Image section
              Stack(
                children: [
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: data.imgPath ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 20,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        controller.dateFields.clear();
                      },
                      child: Container(
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
                  )
                ],
              ),
              SizedBox(height: 15),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  // Listen to scroll events to manage focus
                  onNotification: (ScrollNotification scrollInfo) {
                    return true;
                  },
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: medicineName ?? '',
                            weight: FontWeight.w900,
                            fontSize: 30,
                          ),
                          SizedBox(height: 20),
                          CustomText(text: 'prescribing_physician_name'.tr),
                          SizedBox(height: 10),
                          _buildTextField(
                            context,
                            controller: controller.physicianName,
                            hintText: 'enter_physician_name'.tr,
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
                                    _buildTextField(
                                      context,
                                      controller: controller.dosageController,
                                      hintText: 'eg_500'.tr,
                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(text: 'frequency'.tr),
                                      SizedBox(height: 8),
                                      _buildTextField(
                                        context,
                                        controller:
                                            controller.frequencyController,
                                        hintText: '1',
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                            ],
                          ),
                          SizedBox(height: 20),
                          CustomText(text: 'reason_for_use'.tr),
                          SizedBox(height: 10),
                          _buildTextField(
                            context,
                            controller: controller.reasonController,
                            hintText: 'condition_or_symptom'.tr,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          // Start Date and End Date Row
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(text: 'start_date'.tr),
                                    SizedBox(height: 8),
                                    GestureDetector(
                                      onTap: () => _selectDate(context, controller.startDateController),
                                      child: AbsorbPointer(
                                        child: _buildTextField(
                                          context,
                                          controller: controller.startDateController,
                                          hintText: 'enter_start_date'.tr,
                                          validator: (value) {
                                            if (value == null || value.trim().isEmpty) {
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
                                      onTap: () => _selectDate(context, controller.endDateController),
                                      child: AbsorbPointer(
                                        child: _buildTextField(
                                          context,
                                          controller: controller.endDateController,
                                          hintText: 'enter_end_date'.tr,
                                          validator: (value) {
                                            if (value == null || value.trim().isEmpty) {
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
                                        child: Obx(() => _buildTextField(
                                              context,
                                              controller: TextEditingController(
                                                  text: controller.dateFields.isNotEmpty
                                                      ? controller.dateFields[0].value
                                                      : ""),
                                              hintText: 'set_your_date'.tr,
                                              suffixIcon: Icon(
                                                Icons.watch_later_rounded,
                                                color: Colors.grey,
                                              ),
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
                                        child: Icon(Icons.add, color: Colors.grey),
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
                                                child: Obx(() => _buildTextField(
                                                      context,
                                                      controller: TextEditingController(
                                                          text: controller.dateFields[index].value),
                                                      hintText: 'set_your_date'.tr,
                                                      suffixIcon: Icon(
                                                        Icons.watch_later_rounded,
                                                        color: Colors.grey,
                                                      ),
                                                      validator: (value) {
                                                        if (value == null || value.trim().isEmpty) {
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
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(color: Colors.grey),
                                                color: Color(0xffF9F9F9),
                                              ),
                                              padding: EdgeInsets.all(10),
                                              child: Center(
                                                child: Icon(Icons.delete, color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                );
                              }),
                            ],
                          ),
                          SizedBox(height: 20),
                          Obx(() => CommonButton(
                                title: 'add_to_medicines'.tr,
                                bgColor: Colors.black,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    controller.addToMedicines(data.name ?? '', context);
                                  }
                                },
                                isLoading: controller.isAddToMedicinesLoading.value,
                                borderRadius: 8,
                                fontSize: 16,
                              )),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildTextField(
  BuildContext context, {
  required TextEditingController controller,
  required String hintText,
  Widget? suffixIcon,
  String? Function(String?)? validator,
  TextInputType? keyboardType,
  List<TextInputFormatter>? inputFormatters,
}) {
  final FocusNode focusNode = FocusNode();

  focusNode.addListener(() {
    if (focusNode.hasFocus) {
      Future.delayed(Duration(milliseconds: 300), () {
        Scrollable.ensureVisible(
          context,
          alignment: 0.5,
          duration: Duration(milliseconds: 200),
        );
      });
    }
  });

  return CustomTextField(
    controller: controller,
    focusNode: focusNode,
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
    borderColor: Color(0xffDADADA),
    borderRadius: 8,
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    suffixIcon: suffixIcon != null
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: suffixIcon,
          )
        : null,
    validator: validator,
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
  );
}
}