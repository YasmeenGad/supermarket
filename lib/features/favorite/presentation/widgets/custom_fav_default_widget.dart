import 'package:flutter/material.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/utils/assets.dart';

class CustomFavDefaultWidget extends StatelessWidget {
  const CustomFavDefaultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.imagesEmptyWishList,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Your wishlist is empty!",
            style: AppStyles.styleSemiBold20(context),
          ),
        ],
      ),
    );
  }
}
