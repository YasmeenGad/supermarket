import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/favorite/domain/entities/fav_products.dart';

class CustomFavItem extends StatelessWidget {
  const CustomFavItem({super.key, required this.favorite});
  final Favorite favorite;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
                      imageUrl: "${favorite.products[0].photo}",
                      fit: BoxFit.cover,
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
                        "${favorite.products[0].productName}",
                        style: AppStyles.styleBold16(context)
                            .copyWith(color: darkColor),
                      ),
                      Text(
                        "${favorite.products[0].productDetail}",
                        style: AppStyles.styleMedium14(context)
                            .copyWith(color: secondaryColor),
                      ),
                    ],
                  ),
                ),
                Text(
                  "\$${favorite.products[0].price}",
                  style: AppStyles.styleSemiBold16(context)
                      .copyWith(color: darkColor)
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
