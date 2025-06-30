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
  final Color? borderColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle;
  final double? hintTextPadding;
  final double? leftPadding;
  final FocusNode? focusNode; // Added focusNode parameter

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
    this.borderColor,
    this.contentPadding,
    this.hintStyle,
    this.hintTextPadding,
    this.leftPadding,
    this.focusNode, // Passed focusNode to the constructor
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode, // Added focusNode to TextFormField
      keyboardType: textInputType,
      maxLines: lines,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      readOnly: readOnly,
      initialValue: initialValue,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        filled: fillColor != null,
        fillColor: fillColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding ?? EdgeInsets.only(
          top: 15,
          bottom: 15,
          left: leftPadding ?? 25,
          right: 20,
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 24,
          minHeight: 24,
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: 24,
          minHeight: 24,
        ),
        hintStyle: hintStyle ?? const TextStyle(color: Colors.grey, fontSize: 16),
        enabledBorder: border(),
        focusedBorder: border(),
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
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 5),
      borderSide: BorderSide(
        color: borderColor ?? Colors.black,
      ),
    );
  }
}