import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_quantity_icon.dart';

class QuantityCartSection extends StatelessWidget {
  const QuantityCartSection({super.key, required this.quantity});
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomQuantityIcon(
          icon: Icons.remove,
          iconColor: Color(0xffB3B3B3),
          onTap: () {
            // Handle decrease quantity
          },
        ),
        const SizedBox(width: 8),
        Text(
          '$quantity',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 8),
        CustomQuantityIcon(
          icon: Icons.add,
          iconColor: primaryColor,
          onTap: () {
            // Handle increase quantity
          },
        ),
      ],
    );
  }
}
