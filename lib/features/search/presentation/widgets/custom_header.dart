import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Align(
      alignment: Alignment.center,
      child: Row(
        children: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: darkColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 60),
          FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: Text(
          'Looking for products',
          style: AppStyles.styleBold20(context).copyWith(color: darkColor),
        ),
      ),
        ]
      )
    );
  }
}