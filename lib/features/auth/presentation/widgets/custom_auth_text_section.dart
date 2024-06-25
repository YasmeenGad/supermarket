import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomAuthTextSection extends StatelessWidget {
  const CustomAuthTextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sign Up',
          style: AppStyles.styleSemiBold26.copyWith(color: darkColor),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Enter your credentials to continue',
          style: AppStyles.styleMedium16.copyWith(color: secondaryColor),
        ),
      ],
    );
  }
}
