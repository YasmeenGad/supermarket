import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';

class CustomQuantityIcon extends StatelessWidget {
  const CustomQuantityIcon({super.key, required this.icon, required this.iconColor, this.onTap});
  final IconData icon;
  final Color iconColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
