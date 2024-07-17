import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomSearchCategorySection extends StatelessWidget {
  const CustomSearchCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: Text('Find Products',
                style:
                    AppStyles.styleBold20(context).copyWith(color: darkColor)),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 51,
          decoration: BoxDecoration(
              color: bgTextFieldColor, borderRadius: BorderRadius.circular(16)),
          child: Center(
            child: TextField(
                onChanged: (value) {},
                style:
                    AppStyles.styleMedium14(context).copyWith(color: darkColor),
                cursorColor: darkColor,
                decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.search),
                  border: InputBorder.none,
                  hintText: 'Search store',
                )),
          ),
        ),
        const SizedBox(height: 30,),
      ],
    );
  }
}
