import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomCartDetails extends StatelessWidget {
  const CustomCartDetails({
    super.key,
    required this.productName,
    required this.productDetail,
  });

  final String productName;
  final String productDetail;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: AppStyles.styleSemiBold18(context),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                productDetail,
                style: AppStyles.styleMedium14(context)
                    .copyWith(color: secondaryColor.withOpacity(0.7)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.close_rounded,
            color: Colors.redAccent,
            size: 24,
          ),
        ),
      ],
    );
  }
}
