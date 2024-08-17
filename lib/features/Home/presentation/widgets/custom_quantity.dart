import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_quantity_item.dart';

class CustomQuantity extends StatelessWidget {
  const CustomQuantity({super.key, this.price, required this.quantity, required this.productId});
  final price;
  final int quantity;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomQuantityItem(initialQuantity:  quantity,productId: productId,),
        Expanded(child: SizedBox()),
        Text(
          "\$${price}",
          style: AppStyles.styleBold24(context).copyWith(color: blackColor),
        ),
      ],
    );
  }
}
