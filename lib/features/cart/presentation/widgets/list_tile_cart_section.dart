import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class ListTileCartSection extends StatelessWidget {
  const ListTileCartSection({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        "${title}",
        style: AppStyles.styleBold16(context).copyWith(color: darkColor),
      ),
      subtitle: Text(
        "${subtitle}",
        style: AppStyles.styleMedium14(context).copyWith(color: secondaryColor),
      ),
     
    );
  }
}
