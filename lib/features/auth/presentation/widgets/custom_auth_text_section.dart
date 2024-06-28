import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomAuthTextSection extends StatelessWidget {
  const CustomAuthTextSection({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${title}',
          style: AppStyles.styleSemiBold26(context).copyWith(color: darkColor),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          '${subtitle}',
          style: AppStyles.styleMedium16(context).copyWith(color: secondaryColor),
        ),
      ],
    );
  }
}
