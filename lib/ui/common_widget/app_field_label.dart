import 'package:flutter/material.dart';
import 'package:transact_pay/ui/constant/app_colors.dart';

class AppFieldLable extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final bool optional;

  const AppFieldLable({
    Key? key,
    this.text = '',
    this.textStyle,
    this.optional = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: textStyle ??
                const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
          ),
          if (!optional)
            const Text(
              ' *',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
