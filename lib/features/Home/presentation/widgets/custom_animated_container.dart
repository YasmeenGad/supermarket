import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';

class CustomAnimatedContainer extends StatelessWidget {
  const CustomAnimatedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
          gradient: LinearGradient(
            colors: [primaryColor, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Icon(Icons.add, color: Colors.white, size: 25),
      ),
    );
  }
}
