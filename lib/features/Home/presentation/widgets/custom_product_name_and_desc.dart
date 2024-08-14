import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomProductNameAndDesc extends StatelessWidget {
  const CustomProductNameAndDesc({super.key, this.product});
  final product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${product.productName}",
          style: AppStyles.styleBold16(context).copyWith(
            color: darkColor,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "${product.productDetail}",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppStyles.styleMedium13(context).copyWith(
            color: secondaryColor,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
