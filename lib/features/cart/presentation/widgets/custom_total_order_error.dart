import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';

class CustomTotalOrderError extends StatelessWidget {
  const CustomTotalOrderError(this.message);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(fontSize: 18, color: darkColor),
      ),
    );
  }
}
