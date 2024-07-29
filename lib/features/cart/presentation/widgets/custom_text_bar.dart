import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomTextBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const CustomTextBar({
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: InkWell(
      //   onTap: (){
      //     Navigator.pop(context);
      //   },
      //   child: Icon(Icons.arrow_back_ios, color: darkColor)),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Text(
        text,
        style: AppStyles.styleBold20(context).copyWith(color: darkColor),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
