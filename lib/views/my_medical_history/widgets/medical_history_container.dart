import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    controller.fetchMedicineTranslations(
        [widget.data.medicationCodeableConcept?.text ?? '']);
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
      imageUrl: widget.data.extension.isNotEmpty
          ? widget.data.extension
                  .firstWhere(
                    (ext) => ext.url?.contains('image-url') ?? false,
                    orElse: () => Extension(url: '', valueUrl: '', valueString: ''),
                  )
                  .valueUrl ??
              ''
          : '',
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
                        controller.translatedMedicines[
                                widget.data.medicationCodeableConcept?.text] ??
                            widget.data.medicationCodeableConcept?.text ??
                            '';

                    return Container(
                      width: 80,
                      child: Text(translatedName,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: screenWidth * 0.035,
                            fontFamily: 'Poppins',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
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
                      }
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
                      widget.data.extension.isNotEmpty
                          ? widget.data.extension
                                  .firstWhere(
                                    (ext) =>
                                        ext.url
                                            ?.contains('frequency-display') ??
                                        false,
                                    orElse: () => Extension(
                                        url: '', valueString: '', valueUrl: ''),
                                  )
                                  .valueString ??
                              (widget.data.dosage.isNotEmpty
                                  ? '${widget.data.dosage.first.timing?.repeat?.frequency ?? ''} times daily'
                                  : '')
                          : '',
                      style: TextStyle(
                        fontSize: screenWidth * 0.027,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.themecolor,
                        fontFamily: 'Poppins',
                      ),
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
                      widget.data.dosage.isNotEmpty
                          ? widget.data.dosage.first.text ?? ''
                          : '',
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

    String formatDate(DateTime? date) {
      return date != null ? DateFormat('yyyy-MM-dd').format(date) : '';
    }

    String formatScheduleDate(String? dateString) {
      if (dateString == null || dateString.isEmpty) return '';
      try {
        DateTime dateTime = DateTime.parse(dateString);
        return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
      } catch (e) {
        return dateString;
      }
    }

   String? rawPhysicianText = data.note.first.text;
    if (rawPhysicianText != null && rawPhysicianText.contains('Added by patient or physician:')) {
    controller.physicianName.text = rawPhysicianText.split('Added by patient or physician:').last.trim();
   } else {
    controller.physicianName.text = rawPhysicianText?.trim() ?? '';
   }


    controller.startDateController.text = formatDate(data.effectivePeriod?.start);
    controller.endDateController.text = formatDate(data.effectivePeriod?.end);
    controller.dosageController.text =
        data.dosage.isNotEmpty ? data.dosage.first.text ?? '' : '';
    controller.frequencyController.text = (data.dosage.first.timing?.repeat?.frequency??0).toString();    
    controller.reasonController.text =
        data.reasonCode.isNotEmpty ? data.reasonCode.first.text ?? '' : '';

  controller.dateFields.assignAll(
  data.dosage.first.timing?.event
      .map((dosage) => formatScheduleDate(dosage.toString()))
      .where((text) => text.isNotEmpty)
      .toList() ?? [],
);


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
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            height: screenHeight * 0.95,
            child: Column(
              children: [
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
          imageUrl: widget.data.extension.isNotEmpty
           ? widget.data.extension
                  .firstWhere(
                    (ext) => ext.url?.contains('image-url') ?? false,
                    orElse: () => Extension(url: '', valueUrl: '',valueString: ''),
                  )
                  .valueUrl ??
              ''
          : '',
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
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: screenWidth * 0.55,
                              child: FutureBuilder<String>(
                                future: controller
                                    .translateText(data.medicationCodeableConcept?.text??''),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SizedBox();
                                  } else if (snapshot.hasError) {
                                    return Text(
                                      data.medicationCodeableConcept?.text ?? '',
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
                                      snapshot.data ??
                                          data.medicationCodeableConcept?.text ??
                                          '',
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
                            ),
                            GestureDetector(
                                onTap: () {
                                  controller.updateMedicines(
                                      data.medicationCodeableConcept?.text??'',
                                      int.tryParse(data.id??'')??0,
                                      context);
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
                        CustomText(text: 'prescribing_physician_name'.tr),
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: 'dosage'.tr),
                                  const SizedBox(height: 8),
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
                            const SizedBox(width: 16),
                           Expanded(
                             child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: 'frequency'.tr),
                                  const SizedBox(height: 8),
                                  _buildTextField(
                                    context,
                                    controller: controller.frequencyController,
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
                        const SizedBox(height: 20),
                        CustomText(text: 'reason_for_use'.tr),
                        const SizedBox(height: 10),
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
                                      DateTime? selectedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                      );
                                      if (selectedDate != null) {
                                        controller.startDateController.text =
                                            DateFormat('yyyy-MM-dd').format(selectedDate);
                                      }
                                    },
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
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: 'end_date'.tr),
                                  const SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () async {
                                      DateTime? selectedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                      );
                                      if (selectedDate != null) {
                                        controller.endDateController.text =
                                            DateFormat('yyyy-MM-dd').format(selectedDate);
                                      }
                                    },
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
                        const SizedBox(height: 20),
                        CustomText(text: 'schedule_your_doses'.tr),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            Obx(() {
                              return Column(
                                children: List.generate(controller.dateFields.length, (index) {
                                  return Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () async {
                                              await controller.selectDateTime(index);
                                            },
                                            child: _buildTextField(
                                              context,
                                              controller: TextEditingController(
                                                  text: controller.dateFields[index]),
                                              hintText: 'Select a time',
                                              readOnly: true,
                                              suffixIcon: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: InkWell(
                                                  onTap: () async {
                                                    await controller.selectDateTime(index);
                                                  },
                                                  child: Icon(
                                                    Icons.watch_later_rounded,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
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
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(color: Colors.grey),
                                              color: const Color(0xffF9F9F9),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: const Center(
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
                        ),
                        const SizedBox(height: 20),
                        Obx(() => CommonButton(
                              isLoading: controller.isUpdateLoading.value,
                              title: 'edit'.tr,
                              bgColor: Colors.black,
                              onPressed: () {
                                controller.updateMedicines(
                                    data.medicationCodeableConcept?.text??'',
                                    int.tryParse(data.id??'')??0,
                                    context);
                                Timer(Duration(seconds: 2), () {
                                  controller.getMedications();
                                  controller.isUpdateLoading.value = false;
                                });
                              },
                              borderRadius: 8,
                              fontSize: 16,
                            )),
                        const SizedBox(height: 20),
                      ],
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
        bool? readOnly,
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
      readOnly: readOnly ?? false,
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