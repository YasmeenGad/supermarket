import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/cart/domain/entities/fetch_order_entities.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_cart_details.dart';
import 'package:supermarket/features/cart/presentation/widgets/quantity_cart_section.dart';

class CustomCartItem extends StatelessWidget {
  const CustomCartItem({super.key, required this.order});
  final ProductCart order;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: borderColor.withOpacity(0.3)),
      ),
      color: Colors.white,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: order.photo,
                  width: MediaQuery.of(context).size.width * 0.28,
                  height: MediaQuery.of(context).size.width * 0.28,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Icon(
                    Icons.error_outline,
                    color: Colors.redAccent,
                    size: 40,
                  ),
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
            SizedBox(width: 18),
            Expanded(
              child: Container(
                // height: MediaQuery.of(context).size.width * 0.28,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCartDetails(
                      productId: order.id,
                      productName: order.productName,
                      productDetail: order.productDetail,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        QuantityCartSection(
                          initialQuantity: order.quantity,
                          productId: order.id,
                        ),
                        Text(
                          "\$${order.price.toStringAsFixed(2)}",
                          style: AppStyles.styleSemiBold18(context).copyWith(
                            color: darkColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
