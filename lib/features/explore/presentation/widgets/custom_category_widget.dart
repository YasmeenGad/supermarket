import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomCategoryWidget extends StatelessWidget {
  const CustomCategoryWidget({
    super.key,
    required this.categoryName,
    required this.categoryImage,
  });

  final String categoryName;
  final String categoryImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.filteredProductsViewRoute,
          arguments: categoryName,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
          border: Border.all(width: 1, color: secondaryColor),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: categoryImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.179,
                placeholder: (context, url) => Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: AppStyles.styleBold16(context).copyWith(
                  color: darkColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
