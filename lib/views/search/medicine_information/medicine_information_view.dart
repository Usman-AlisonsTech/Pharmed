import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/connect_phar/connect_phar_view.dart';
import 'package:pharmed_app/views/home/home_controller.dart';
import 'package:pharmed_app/models/popular_medication_model.dart';
import 'package:pharmed_app/views/search/medicine_information/medicine_information_controller.dart';

class MedicineInformationView extends StatefulWidget {
  final String medicineName;
  final List<dynamic> jsonData;
  final RxBool isLoading;
  final Datum? data;

  MedicineInformationView({
    super.key,
    required this.jsonData,
    required this.medicineName,
    required this.isLoading,
    this.data,
  });

  @override
  State<MedicineInformationView> createState() =>
      _MedicineInformationViewState();
}

class _MedicineInformationViewState extends State<MedicineInformationView> {
  final RxList<dynamic> savedData = <dynamic>[].obs;
  final homeController = Get.find<HomeController>();
  final controller = Get.put(MedicineInformationController());
  final RxMap<String, String> translations = <String, String>{}.obs;

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
          ));
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: ScreenConstants.screenhorizontalPadding,
                right: ScreenConstants.screenhorizontalPadding,
                top: screenHeight * 0.10,
                bottom: screenHeight * 0.2,
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
                              return const Center(
                                child: SizedBox(),
                              );
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
                      (widget.jsonData.length == 1 &&
                              widget.jsonData[0]["message"] ==
                                  "No Search History")
                          ? SizedBox()
                          : GestureDetector(
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
                  SizedBox(height: screenHeight * 0.05),
                  ..._buildWidgets(widget.jsonData),
                ],
              ),
            ),
          );
        }
      }),
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
}