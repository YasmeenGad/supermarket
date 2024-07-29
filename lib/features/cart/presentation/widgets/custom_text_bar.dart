import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomTextBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Text("My Cart", style: AppStyles.styleBold20(context).copyWith(color :darkColor),),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}