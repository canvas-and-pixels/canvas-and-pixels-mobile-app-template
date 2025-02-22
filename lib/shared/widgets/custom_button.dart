import 'package:canvas_and_pixels_mobile_app_template/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double borderRadius;
  final bool isLoading;
  final double? width;
  final double height;
  final TextStyle? textStyle;
  final IconData? icon;
  final Color? iconColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.borderRadius = 8.0,
    this.isLoading = false,
    this.width,
    this.height = 50,
    this.textStyle,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).primaryColor,
          foregroundColor: textColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        onPressed: isLoading ? null : onPressed,
        child: AlternateDisplay(
          control: isLoading,
          initialChild: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: iconColor ?? textColor ?? Colors.white),
                const SizedBox(width: 8),
              ],
              CustomText(
                text: text,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.white,
              )
            ],
          ),
          finalChild: const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ),
    );
  }
}
