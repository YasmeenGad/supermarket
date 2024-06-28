import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 67,
      decoration: BoxDecoration(
        color: Color(0xff53B175),
        borderRadius: BorderRadius.circular(19),
      ),
      child: Center(child: Text(text, style: AppStyles.styleSemiBold18(context).copyWith(color: whiteColor))),
    );
  }
}
