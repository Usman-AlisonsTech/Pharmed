import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/models/medicine_info_response_model.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/connect_phar/connect_phar_view.dart';
import 'package:pharmed_app/views/home/home_controller.dart';
import 'package:pharmed_app/views/search/medicine_information/medicine_information_controller.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'package:pharmed_app/widgets/custom_textfield.dart';
class MedicineInformationView extends StatefulWidget {
  final String medicineName;
  final Rx<MedicineInformationResponseModel?> medicineData;
  final RxBool isLoading;

  const MedicineInformationView({
    super.key,
    required this.medicineData,
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
  final RxMap<String, String> translations = <String, String>{}.obs;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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

  Widget _buildContentList(List<String> items, String emptyMessage, bool isDark) {
  if (items.isEmpty) {
    return Center(
      child: FutureBuilder<String>(
        future: controller.translateText(emptyMessage),
        builder: (context, snapshot) {
          return Text(
            snapshot.data ?? emptyMessage,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
              color: isDark? Colors.white70 : Colors.grey,
            ),
            textAlign: TextAlign.center,
          );
        },
      ),
    );
  }

  return ListView.builder(
    padding: const EdgeInsets.symmetric(vertical: 10),
    itemCount: items.length,
    itemBuilder: (context, index) {
      return Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: FutureBuilder<String>(
          future: controller.translateText(items[index]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 10,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }
            
            return Text(
              snapshot.data ?? items[index],
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
                color:isDark? Colors.white70 : Colors.black87,
                height: 1.5,
              ),
            );
          },
        ),
      );
    },
  );
}

  Widget _buildNoDataMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'no_medicine_history'.tr,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'try_searching_different_medicine'.tr,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final isDark = Theme.of(context).brightness == Brightness.dark;

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
          // Check if there's no data
          if (widget.medicineData.value == null) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: ScreenConstants.screenhorizontalPadding,
                  right: ScreenConstants.screenhorizontalPadding,
                  top: screenHeight * 0.055,
                ),
                child: Column(
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
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.2),
                    _buildNoDataMessage(),
                  ],
                ),
              ),
            );
          }

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
                            color: isDark? Colors.grey[700]: Colors.black,
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
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelColor: isDark? Colors.white: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: ColorConstants.themecolor,
                    labelStyle: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                    tabs:  [
                      Tab(text: 'uses'.tr),
                      Tab(text: 'side_effect'.tr),
                      Tab(text: 'precautions'.tr),
                      Tab(text: 'warnings'.tr),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    height: screenHeight * 0.6,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildContentList(
                          widget.medicineData.value!.usage,
                          'no_warning_info_available'.tr,isDark
                        ),
                        _buildContentList(
                          widget.medicineData.value!.dosage,
                          'no_dosage_info_available'.tr,isDark
                        ),
                        _buildContentList(
                          widget.medicineData.value!.precautions,
                          'no_precaution_info_available'.tr,isDark
                        ),
                        _buildContentList(
                          widget.medicineData.value!.warnings,
                          'no_warning_info_available'.tr,isDark
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
      }),
      bottomNavigationBar:
          Obx((){
            if(widget.medicineData.value == null){
                return SizedBox();
            }else{
              return Padding(
                padding:  EdgeInsets.only(
                    left: 25, right: 25, bottom: 20, top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonButton(
                      onPressed: () {
                        if (widget.medicineData.value == null) {
                          return;
                        } else {
                          _showBottomSheet(context, widget.medicineName, isDark);
                        }
                      },
                      title: 'add_to_medicines'.tr,
                      bgColor:isDark? Colors.grey[700]:  Colors.black,
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
              );
            }
          }
          ),
    );
  }


  void _showBottomSheet(BuildContext context, medicineName,bool isDark) {
  final HomeController controller = Get.find<HomeController>();
  final MedicineInformationController medicineInfoController = Get.find<MedicineInformationController>();
  final _formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    isDismissible: false,
    context: context,
    isScrollControlled: true,
    backgroundColor:isDark ? Color(0xFF121212): Colors.white,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
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
                  ),
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
                         FutureBuilder<String>(
                          future: medicineInfoController.translateText(widget.medicineName),
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
                                      controller.addDateField();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey),
                                        color: isDark? Colors.black: Color(0xffF9F9F9),
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
                                                color:isDark? Colors.black: Color(0xffF9F9F9),
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
                        bgColor: ColorConstants.themecolor,
                        borderColor: ColorConstants.themecolor,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.addToMedicines(widget.medicineName, context);
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
