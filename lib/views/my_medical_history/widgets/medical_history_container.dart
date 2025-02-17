import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmed_app/models/get_medication_response_model.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/my_medical_history/my_medical_history_controller.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'package:pharmed_app/widgets/custom_textfield.dart';

class MedicalHistoryContainer extends StatefulWidget {
  final Datum data;
  const MedicalHistoryContainer({super.key, required this.data});

  @override
  State<MedicalHistoryContainer> createState() =>
      _MedicalHistoryContainerState();
}

class _MedicalHistoryContainerState extends State<MedicalHistoryContainer> {
  final MyMedicalHistoryController controller =
      Get.find<MyMedicalHistoryController>();

  @override
  void initState() {
    super.initState();
    controller.fetchMedicineTranslations([widget.data.medicine ?? '']);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(0, 4),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.035, vertical: screenHeight * 0.017),
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.3,
            height: screenHeight * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: widget.data.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(strokeWidth: 3),
                  ),
                ),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, size: 20, color: Colors.red),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Obx(() {
                    String translatedName =
                        controller.translatedMedicines[widget.data.medicine] ??
                            widget.data.medicine ??
                            '';

                    return CustomText(
                      text: translatedName,
                      weight: FontWeight.w700,
                      fontSize: screenWidth * 0.035,
                    );
                  }),
                  SizedBox(
                    width: screenWidth * 0.1,
                  ),
                  PopupMenuButton<String>(
                    icon: SvgPicture.asset(
                      'assets/svg/three_dots.svg',
                      width: 5,
                      height: 5,
                    ),
                    onSelected: (String value) {
                      if (value == 'Option 1') {
                        controller.dateFields.clear();
                        _showBottomSheet(context, value, widget.data);
                      } else if (value == 'Option 2') {}
                    },
                    color: Colors.white,
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          value: 'Option 1',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: 'edit'.tr),
                              const Icon(
                                Icons.edit,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                  )
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              Row(
                children: [
                  CustomText(
                    text: 'frequency'.tr,
                    fontSize: screenWidth * 0.027,
                    weight: FontWeight.w700,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  SizedBox(
                    width: 100,
                    child: Text(
                      widget.data.frequency,
                      style: TextStyle(
                          fontSize: screenWidth * 0.027,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.themecolor,
                          fontFamily: 'Poppins'),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.015),
              Row(
                children: [
                  CustomText(
                    text: 'dosage'.tr,
                    fontSize: screenWidth * 0.027,
                    weight: FontWeight.w700,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  SizedBox(
                    width: 115,
                    child: Text(
                      widget.data.dosage,
                      style: TextStyle(
                        fontSize: screenWidth * 0.027,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.themecolor,
                        fontFamily: 'Poppins',
                      ),
                      softWrap: true,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context, String option, Datum data) {
    final MyMedicalHistoryController controller =
        Get.find<MyMedicalHistoryController>();

    // Format the date safely before assigning it
    String formatDate(DateTime? date) {
      return date != null ? DateFormat('yyyy-MM-dd').format(date) : '';
    }

    String formatScheduleDate(String? dateString) {
      if (dateString == null || dateString.isEmpty) return '';
      try {
        DateTime dateTime = DateTime.parse(dateString);
        return DateFormat('yyyy-MM-dd HH:mm:ss')
            .format(dateTime); // Updated format
      } catch (e) {
        return dateString; // Return as-is if parsing fails
      }
    }

    controller.physicianName.text = data.physicianName;
    controller.startDateController.text = formatDate(data.startDate);
    controller.endDateController.text = formatDate(data.endDate);
    controller.dosageController.text = data.dosage;
    controller.frequencyController.text = data.frequency;
    controller.reasonController.text = data.reason;

    controller.dateFields.assignAll(data.medicalSchedule?.map((schedule) {
          // Ensure schedule.schedule is a DateTime and format it
          if (schedule.schedule is DateTime) {
            return DateFormat('yyyy-MM-dd HH:mm:ss').format(schedule.schedule);
          } else {
            return ''; // Fallback in case it's not a DateTime
          }
        }).toList() ??
        []);

    showModalBottomSheet(
      isDismissible: false,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return Container(
          padding: const EdgeInsets.all(0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: screenHeight * 0.9,
          child: Column(
            children: [
              // Image section
              Stack(
                children: [
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.3,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: data.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(strokeWidth: 3),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error, size: 20, color: Colors.red),
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
                        child: const Center(
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
              const SizedBox(height: 15),
              // Scrollable content section
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title Row with edit icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: data.medicine,
                            weight: FontWeight.w900,
                            fontSize: 30,
                          ),
                          GestureDetector(
                              onTap: () {
                                controller.updateMedicines(
                                    data.medicine, data.id, context);
                                Timer(Duration(seconds: 3), () {
                                  controller.getMedications();
                                  controller.isUpdateLoading.value = false;
                                });
                              },
                              child: SvgPicture.asset(
                                  'assets/svg/tabler_edit.svg'))
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Prescribing physician name
                      CustomText(text: 'prescribing_physician_name'.tr),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                        controller: controller.physicianName,
                        hintText: 'enter_physician_name'.tr,
                        borderColor: const Color(0xffDADADA),
                        borderRadius: 8,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: 'start_date'.tr),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () async {
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );
                                    if (selectedDate != null) {
                                      controller.startDateController.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(selectedDate);
                                    }
                                  },
                                  child: AbsorbPointer(
                                    child: CustomTextField(
                                      hintStyle: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                      controller:
                                          controller.startDateController,
                                      hintText: 'enter_start_date'.tr,
                                      borderColor: const Color(0xffDADADA),
                                      borderRadius: 8,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: 'end_date'.tr),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () async {
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );
                                    if (selectedDate != null) {
                                      // Update the endDateController text with the selected date
                                      controller.endDateController.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(selectedDate);
                                    }
                                  },
                                  child: AbsorbPointer(
                                    child: CustomTextField(
                                      hintStyle: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                      controller: controller.endDateController,
                                      hintText: 'enter_end_date'.tr,
                                      borderColor: const Color(0xffDADADA),
                                      borderRadius: 8,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      // Dosage and Frequency Row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: 'dosage'.tr),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () async {},
                                  child: CustomTextField(
                                    hintStyle: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                    controller: controller.dosageController,
                                    hintText: 'eg_500'.tr,
                                    borderColor: const Color(0xffDADADA),
                                    borderRadius: 8,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: 'frequency'.tr),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () async {},
                                  child: CustomTextField(
                                    hintStyle: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                    controller: controller.frequencyController,
                                    hintText: 'eg_twice_daily'.tr,
                                    borderColor: const Color(0xffDADADA),
                                    borderRadius: 8,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomText(text: 'reason_for_use'.tr),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: controller.reasonController,
                        hintText: 'condition_or_symptom'.tr,
                        borderColor: const Color(0xffDADADA),
                        hintStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                        borderRadius: 8,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                      ),
                      const SizedBox(height: 20),
                      CustomText(text: 'schedule_your_doses'.tr),
                      const SizedBox(height: 10),

                      Column(
                        children: [
                          Obx(() {
                            return Column(
                              children: List.generate(
                                  controller.dateFields.length, (index) {
                                return Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            await controller
                                                .selectDateTime(index);
                                          },
                                          child: CustomTextField(
                                            controller: TextEditingController(
                                                text: controller
                                                    .dateFields[index]),
                                            hintText: 'Select a time',
                                            borderColor:
                                                const Color(0xffDADADA),
                                            suffixIcon: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: InkWell(
                                                onTap: () async {
                                                  await controller
                                                      .selectDateTime(index);
                                                },
                                                child: Icon(
                                                  Icons.watch_later_rounded,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            readOnly: true,
                                            borderRadius: 8,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          controller.removeDateField(index);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border:
                                                Border.all(color: Colors.grey),
                                            color: const Color(0xffF9F9F9),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: const Center(
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
                        ],
                      ),

                      const SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            controller.addDateField();
                          },
                          child: Container(
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                              color: const Color(0xffF9F9F9),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                weight: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // Fixed bottom button
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1, vertical: 20),
                child: Obx(
                  () => CommonButton(
                    isLoading: controller.isUpdateLoading.value,
                    title: 'edit'.tr,
                    bgColor: Colors.black,
                    onPressed: () {
                      controller.updateMedicines(
                          data.medicine, data.id, context);
                      Timer(Duration(seconds: 2), () {
                        controller.getMedications();
                        controller.isUpdateLoading.value = false;
                      });
                    },
                    borderRadius: 8,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
