import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/assets.dart';

class CustomEmptyCartContent extends StatelessWidget {
  const CustomEmptyCartContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.imagesEmptycart),
                const SizedBox(height: 16),
                Text(
                  "Your cart is empty",
                  style: TextStyle(fontSize: 18, color: darkColor),
                ),
                const SizedBox(height: 8),
                Text(
                  "Looks like you haven't added anything to your cart yet",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: secondaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
