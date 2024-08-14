import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';

class CustomQuantityIcon extends StatelessWidget {
  const CustomQuantityIcon({super.key, required this.icon, required this.iconColor});
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: borderColor),
      ),
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
