import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/features/cart/domain/entities/create_order_entity.dart';
import 'package:supermarket/features/cart/presentation/widgets/list_tile_cart_section.dart';
import 'package:supermarket/features/cart/presentation/widgets/quantity_cart_section.dart';

class CustomCartItem extends StatelessWidget {
  const CustomCartItem({super.key, required this.order});
  final MyOrder order;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 7.5,
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Image.asset(
                    Assets.imagesApple,
                    width: 120,
                    height: 120,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTileCartSection(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            QuantityCartSection(),
                            Text(
                              "\$5.00",
                              style: AppStyles.styleSemiBold18(context)
                                  .copyWith(color: darkColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
