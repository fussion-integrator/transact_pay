import 'package:flutter/material.dart';
import 'package:transact_pay/ui/constant/app_colors.dart';

class AppButton extends StatelessWidget {
  final double height;
  final double width;
  final Color backgroundColor;
  final String text;
  final TextStyle textStyle;
  final Color foregroundColor;
  final double borderRadius;
  final VoidCallback? onPressed;

  const AppButton({
    Key? key,
    this.height = 50.0, // Default height
    this.width = double.infinity, // Default width takes all available space
    this.backgroundColor = AppColors.primaryColor, // Default background color
    required this.text, // Required parameter for text
    this.textStyle = const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white), // Default text style
    this.foregroundColor = Colors.white, // Default foreground color
    this.borderRadius = 8.0, // Default border radius
    this.onPressed, // Optional onPressed callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // Background color of the button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
        child: Text(
          text,
          style: textStyle, // Text style with foreground color
        ),
      ),
    );
  }
}
