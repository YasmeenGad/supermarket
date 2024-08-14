import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_animated_container.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_image.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_product_name_and_desc.dart';

class CustomBestSellerWidget extends StatelessWidget {
  const CustomBestSellerWidget({super.key, required this.product});
  final product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: MediaQuery.sizeOf(context).width * 0.9,
      height: MediaQuery.sizeOf(context).height * 0.18,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: Colors.transparent),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
        gradient: LinearGradient(
          colors: [Color(0xfff8f8f8), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.17,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [Colors.white, Color(0xfff8f8f8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CustomImage(
                  image: product.photo,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomProductNameAndDesc(product: product),
                  Spacer(),
                  Row(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "\$${product.price}",
                          style: AppStyles.styleSemiBold18(context).copyWith(
                            color: darkColor,
                            fontSize: 22,
                            letterSpacing: 0.5,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      CustomAnimatedContainer(),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
