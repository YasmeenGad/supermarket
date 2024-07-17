import 'package:flutter/cupertino.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomCategoryWidget extends StatelessWidget {
  const CustomCategoryWidget(
      {super.key,
      required this.categoryName,
      required this.categoryImage,
      required this.color});
  final String categoryName;
  final Widget categoryImage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          categoryImage,
          Text("${categoryName}", style: AppStyles.styleBold16(context).copyWith(color: darkColor),),
        ],
      ),
    );
  }
}
