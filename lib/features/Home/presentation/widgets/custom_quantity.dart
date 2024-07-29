import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_quantity_item.dart';

class CustomQuantity extends StatelessWidget {
  const CustomQuantity({super.key, this.price, required this.quantity});
  final price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomQuantityItem(quantity: quantity,),
        Expanded(child: SizedBox()),
        Text(
          "\$${price}",
          style: AppStyles.styleBold24(context).copyWith(color: blackColor),
        ),
      ],
    );
  }
}
