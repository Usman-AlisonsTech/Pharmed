import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final double? padding;
  final TextInputType? textInputType;
  final int? lines;
  final bool forceBorder;
  final double? borderRadius;
  final bool obscureText;
  final bool readOnly;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Color? borderColor; // Added borderColor parameter
  final EdgeInsetsGeometry? contentPadding; // Added contentPadding parameter
  final TextStyle? hintStyle; // Added hintStyle parameter
  final double? hintTextPadding; // Added hintTextPadding parameter
  final double? leftPadding; // Added leftPadding parameter

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.initialValue,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.padding,
    this.textInputType,
    this.lines = 1,
    this.obscureText = false,
    this.forceBorder = false,
    this.readOnly = false,
    this.validator,
    this.onChanged,
    this.borderRadius,
    this.borderColor, // Passed borderColor to the constructor
    this.contentPadding, // Passed contentPadding to the constructor
    this.hintStyle, // Passed hintStyle to the constructor
    this.hintTextPadding, // Passed hintTextPadding to the constructor
    this.leftPadding, // Passed leftPadding to the constructor
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      maxLines: lines,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      readOnly: readOnly,
      initialValue: initialValue,
      style: TextStyle(
        fontFamily: 'Poppins', // Ensure Poppins font is applied
        fontWeight: FontWeight.w500, // Set font weight to 500
      ),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        filled: fillColor != null,
        fillColor: fillColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding ?? EdgeInsets.only(
          top: 15, // Padding from top
          bottom: 15, // Padding from bottom
          left: leftPadding ?? 25, // Padding on the left side (fallback to 25 if not provided)
          right: 20, // Padding on the right side (you can adjust it as needed)
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 24, // Set a minimum width to ensure proper size of the icon
          minHeight: 24, // Set a minimum height to center the icon vertically
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: 24, // Make sure suffix icon has sufficient space
          minHeight: 24, // Ensure it's vertically aligned
        ),
        hintStyle: hintStyle ?? const TextStyle(color: Colors.grey, fontSize: 16), // Fallback to default hintStyle
        enabledBorder: border(), // Use the border function for styling
        focusedBorder: border(), // Use the same border for focused state
        errorBorder: errorBorder(),
        focusedErrorBorder: errorBorder(),
      ),
    );
  }

  // Function to handle error border styling
  OutlineInputBorder errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.red[900]!),
    );
  }

  // Function to handle default border styling
  OutlineInputBorder border() {
    // If borderColor is not passed, default to black
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 5),
      borderSide: BorderSide(
        color: borderColor ?? Colors.black, // Use borderColor or default to black
      ),
    );
  }
}
