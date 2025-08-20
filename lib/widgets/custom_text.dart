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
  final TextDecoration? decoration;
  final double decorationThickness;
  final TextDecorationStyle? decorationStyle;
  final Color? decorationColor;

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
    this.decoration = TextDecoration.none,
    this.decorationThickness = 1.0,
    this.decorationStyle = TextDecorationStyle.solid,
    this.decorationColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      text,
      maxLines: lines,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: weight,
        fontStyle: fontStyle,
        fontFamily: 'Poppins',
        color: color ?? theme.textTheme.bodyMedium?.color, // 👈 auto color
        decoration: decoration,
        decorationThickness: decorationThickness,
        decorationStyle: decorationStyle ?? TextDecorationStyle.solid,
        decorationColor:
            decorationColor ?? color ?? theme.textTheme.bodyMedium?.color,
      ),
    );
  }
}
