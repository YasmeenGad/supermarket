import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_animated_container.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_image.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_product_name_and_desc.dart';

class ExclusiveOfferWidget extends StatelessWidget {
  const ExclusiveOfferWidget({super.key, required this.product});
  final product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.423,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: Colors.transparent),
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xfff8f8f8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            // spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.35,
                height: MediaQuery.sizeOf(context).height * 0.18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [Colors.white, Color(0xfff8f8f8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CustomImage(image: product.photo,),
                ),
              ),
            ),
            const SizedBox(height: 10),
            CustomProductNameAndDesc(
              product: product,
            ),
            const Spacer(),
            Row(
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "\$${product.price}",
                    style: AppStyles.styleSemiBold18(context).copyWith(
                      color: darkColor,
                      fontSize: 20,
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
    );
  }
}
