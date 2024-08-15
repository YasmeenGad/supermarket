import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomListTileCheckout extends StatelessWidget {
  const CustomListTileCheckout({super.key, required this.title, required this.trailing});
  final String title;
  final trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          title,
          style: AppStyles.styleSemiBold20(context)
              .copyWith(color: secondaryColor),
        ),
        trailing: trailing);
  }
}
