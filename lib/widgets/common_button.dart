import 'package:flutter/material.dart';
import 'package:pharmed_app/widgets/custom_text.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final bool isTransparent;
  final bool isEnabled;
  final Color? bgColor; // Background color
  final Color? borderColor; // Border color
  final Color textColor;
  final Widget? icon;
  final Widget? trailingIcon; // Added trailingIcon
  final double fontSize;
  final bool isLoading;
  final double horizontalPadding,
      verticalPadding; // Renamed to verticalPadding for clarity
  final double borderRadius;
  final FontWeight textWeight;
  final Color? buttonShade;
  final Color? shadowColor; // Added shadowColor
  final String? fontFamily; // Nullable fontFamily, so it falls back to default

  CommonButton({
    super.key,
    required this.title,
    this.onPressed,
    this.isTransparent = false,
    this.bgColor, // Background color (can be null)
    this.borderColor, // Border color (can be null)
    this.textColor = Colors.white,
    this.icon,
    this.trailingIcon, // Initialize trailingIcon
    this.horizontalPadding = 0,
    this.verticalPadding = 15, // Set a default value for vertical padding
    this.fontSize = 14,
    this.isEnabled = true,
    this.isLoading = false,
    this.borderRadius = 8.0, // Default to 8px if not provided
    this.textWeight = FontWeight.w700, // Default text weight
    this.buttonShade, // Default button shade
    this.shadowColor, // Default shadow color (black)
    this.fontFamily, // Make fontFamily nullable
  });

  @override
  Widget build(BuildContext context) {
    // Set default values for bgColor and borderColor
    final buttonBgColor =
        bgColor ?? Colors.grey[300]; // Default to black if not provided
    final buttonBorderColor =
        borderColor ?? Colors.black; // Default to black if not provided

    // Use default shadow color or black
    final shadow = shadowColor ?? Colors.black; // Default shadow color is black

    // Apply the box shadow to the decoration
    return InkWell(
      onTap: isLoading || !isEnabled ? null : onPressed,
      child: Container(
        width: horizontalPadding > 0
            ? null
            : double
                .infinity, // This ensures the button takes up full width if no horizontal padding
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding, // Apply the vertical padding here
          horizontal: horizontalPadding, // Apply the horizontal padding here
        ),
        decoration: BoxDecoration(
          color: !isEnabled
              ? Colors.grey[300] // Disable color if not enabled
              : isTransparent
                  ? buttonBgColor // Use the background color
                  : buttonBgColor, // Use the background color if transparent
          borderRadius: BorderRadius.circular(
              borderRadius), // Use the passed borderRadius or default to 8.0
          border: Border.all(
            color: !isEnabled ? Colors.grey : buttonBorderColor, // Border color
            width: 1.5, // You can customize the border width here
          ),
          boxShadow: [
            BoxShadow(
              color: shadow.withOpacity(0.5), // Apply shadow with opacity
              offset: const Offset(0, 4), // Shadow offset (X and Y axis)
              blurRadius: 6, // Blur radius for the shadow
              spreadRadius: 0, // Spread radius of the shadow
            ),
          ],
        ),
        child: isLoading
            ? const Center(
                child: SizedBox(
                  width: 21,
                  height: 21,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    SizedBox(width: 10), // Space between icon and text
                  ],
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: fontSize,
                        color: isTransparent ? null : textColor,
                        fontWeight: textWeight,
                        fontFamily: fontFamily ?? null // Use system default if null
                    ),
                  ),
                  if (trailingIcon != null) ...[
                    SizedBox(width: 10), // Space between text and trailing icon
                    trailingIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}
