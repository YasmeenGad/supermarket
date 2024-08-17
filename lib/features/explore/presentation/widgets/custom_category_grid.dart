import 'package:flutter/material.dart';
import 'package:supermarket/features/explore/presentation/widgets/custom_category_widget.dart';

class CustomCategoryGrid extends StatelessWidget {
  const CustomCategoryGrid(this.categories);
  final List categories;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final category = categories[index];
          return CustomCategoryWidget(
            categoryName: category.categoryName,
            categoryImage: category.imageUrl,
          );
        },
        childCount: categories.length,
      ),
    );
  }
}
