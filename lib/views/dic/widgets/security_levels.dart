import 'package:flutter/material.dart';
import 'package:pharmed_app/widgets/custom_text.dart';

class SecurityLevels extends StatelessWidget {
  final String levelName;
  final String desc;
  final Color color;
  final Color textColor;
  const SecurityLevels(
      {super.key,
      required this.levelName,
      required this.desc,
      required this.color,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 30),
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.012,
          ),
          width: screenWidth*0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color,
          ),
          child: Center(
            child: CustomText(
              text: levelName,
              weight: FontWeight.w700,
              color: textColor,
              fontSize: screenWidth * 0.04,
            ),
          ),
        ),
        SizedBox(width: screenWidth * 0.035),
        Expanded(
          child: CustomText(
            text: desc,
            fontSize: screenWidth * 0.031,
            weight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
