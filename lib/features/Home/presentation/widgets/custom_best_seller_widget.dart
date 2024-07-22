import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_image.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_product_name_and_desc.dart';

class CustomBestSellerWidget extends StatelessWidget {
  const CustomBestSellerWidget({super.key, required this.product});
  final product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.sizeOf(context).width * 0.9,
      height: MediaQuery.sizeOf(context).height * 0.17,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: Color(0xffE7E7E7)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.17,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CustomImage(
                  image: product.photo,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
              child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomProductNameAndDesc(
                  product: product,
                ),
                Spacer(),
                Row(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "\$${product.price}",
                        style: AppStyles.styleSemiBold18(context)
                            .copyWith(color: darkColor),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
