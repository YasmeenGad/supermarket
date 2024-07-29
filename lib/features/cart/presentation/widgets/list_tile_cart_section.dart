import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class ListTileCartSection extends StatelessWidget {
  const ListTileCartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        "Apple",
        style: AppStyles.styleBold16(context).copyWith(color: darkColor),
      ),
      subtitle: Text(
        "1kg",
        style: AppStyles.styleMedium14(context).copyWith(color: secondaryColor),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.close,
          size: 14,
          color: Color(0xffB3B3B3),
        ),
      ),
    );
  }
}
