import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/utils/assets.dart';

class CustomFavItem extends StatelessWidget {
  const CustomFavItem({super.key});

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
                  child: Image.asset(
                    Assets.imagesApple,
                    fit: BoxFit.cover,
                    height: MediaQuery.sizeOf(context).height * 0.15,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Apple",
                        style: AppStyles.styleBold16(context)
                            .copyWith(color: darkColor),
                      ),
                      Text(
                        "1 kg",
                        style: AppStyles.styleMedium14(context)
                            .copyWith(color: secondaryColor),
                      ),
                    ],
                  ),
                ),
                Text(
                  "\$ 1.00",
                  style: AppStyles.styleSemiBold16(context).copyWith(color: darkColor)
                      .copyWith(color: darkColor),
                ),
            Icon(Icons.arrow_forward_ios, size: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
