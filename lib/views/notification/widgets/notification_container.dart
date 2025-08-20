import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/widgets/custom_text.dart';

class NotificationContainer extends StatelessWidget {
  final String title;
  final String frequency;
  final String dosage;
  final String time;
  final String note;
  const NotificationContainer({super.key, required this.title, required this.frequency, required this.time, required this.note, required this.dosage});

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: time,
            weight: FontWeight.w500,
            fontSize: 13,
          ),
          SizedBox(height:  5),
             Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: ColorConstants.themecolor,
                  borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    weight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                        CustomText(
                        text: '${'dosage'.tr}:',
                        weight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: dosage,
                        weight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                   SizedBox(height: 5),
                  Row(
                    children: [
                        CustomText(
                        text: '${'note'.tr}:',
                        weight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: note,
                        weight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
