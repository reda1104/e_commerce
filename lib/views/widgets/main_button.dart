import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final double height;
  final VoidCallback? onTap;
  final Color backGroundColor;
  final Color foreGroundColor;
  final String text;

  const MainButton({
    super.key,
    this.height = 60,
    this.onTap,
    this.backGroundColor = AppColors.primaryColor,
    this.foreGroundColor = Colors.white,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backGroundColor,
          foregroundColor: foreGroundColor,
        ),
        child: Text(text),
      ),
    );
  }
}
