import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? weight;
  final Color? color;
  final int? lines;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TextOverflow? textOverflow;
  final TextDecoration? decoration; // Added decoration parameter
  final double decorationThickness; // Added thickness for underline
  final TextDecorationStyle? decorationStyle; // Added decorationStyle parameter
  final Color? decorationColor; // Added decorationColor parameter

  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 15,
    this.weight,
    this.color,
    this.lines,
    this.fontStyle,
    this.textOverflow,
    this.textAlign,
    this.decoration = TextDecoration.none, // Default is no decoration
    this.decorationThickness = 1.0, // Default thickness for the underline
    this.decorationStyle = TextDecorationStyle.solid, // Default to solid underline style
    this.decorationColor, // Passed decorationColor to the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: lines,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: weight,
        fontStyle: fontStyle,
        overflow: textOverflow,
        fontFamily: 'Poppins',
        decoration: decoration, // Apply decoration (underline, etc.)
        decorationThickness: decorationThickness, // Adjust underline thickness
        decorationStyle: decorationStyle ?? TextDecorationStyle.solid, // Apply decoration style
        decorationColor: decorationColor ?? color, // Set the underline color, default to text color
      ),
    );
  }
}
