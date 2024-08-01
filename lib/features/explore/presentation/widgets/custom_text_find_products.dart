import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomTextFindProducts extends StatelessWidget {
  const CustomTextFindProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: Text(
          'Find Products',
          style: AppStyles.styleBold20(context).copyWith(color: darkColor),
        ),
      ),
    );
  }
}
