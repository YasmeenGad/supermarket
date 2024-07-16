import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomListTileProductDetails extends StatelessWidget {
  const CustomListTileProductDetails(
      {super.key, required this.productName, required this.productDetails});
  final String productName;
  final String productDetails;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  "${productName}",
                  style: AppStyles.styleBold24(context)
                      .copyWith(color: blackColor),
                )),
            subtitle: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  "${productDetails}, Price",
                  style: AppStyles.styleMedium16(context)
                      .copyWith(color: secondaryColor),
                )),
            trailing: Icon(
              Icons.favorite_outline,
              color: darkColor,
            ),
          ),
        )
      ],
    );
  }
}
