import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:supermarket/core/constants/app_colors.dart'; // Ensure you have the correct path

class CustomButton extends StatelessWidget {
  final String text;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: isLoading
            ? SpinKitCircle(
                color: primaryColor,
                size: 40,
              )
            : Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
      ),
    );
  }
}
