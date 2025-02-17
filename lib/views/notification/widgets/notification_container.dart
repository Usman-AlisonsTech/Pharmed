import 'package:flutter/material.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/widgets/custom_text.dart';

class NotificationContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  const NotificationContainer({super.key, required this.title, required this.subtitle, required this.time});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: time,
            weight: FontWeight.w500,
            fontSize: 16,
          ),
          SizedBox(width: screenWidth * 0.1),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: ColorConstants.themecolor,
                  borderRadius: BorderRadius.circular(16)),
              padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 80),
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
                  CustomText(
                    text: subtitle,
                    weight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
