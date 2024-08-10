import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomFavItem extends StatelessWidget {
  const CustomFavItem({super.key, required this.product});
  final  product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.15,
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                      imageUrl: product.photo ?? "",
                      fit: BoxFit.cover,
                      width: 100,
                      height: double.infinity,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: Colors.red,
                          )),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName,
                        style: AppStyles.styleBold16(context)
                            .copyWith(color: darkColor),
                      ),
                      Text(
                        product.productDetail,
                        style: AppStyles.styleMedium14(context)
                            .copyWith(color: secondaryColor),
                      ),
                    ],
                  ),
                ),
                Text(
                  "\$${product.price}",
                  style: AppStyles.styleSemiBold16(context)
                      .copyWith(color: darkColor),
                ),
                SizedBox(width: 8,),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
