import 'package:flutter/material.dart';
import 'package:supermarket/features/favorite/presentation/widgets/custom_fav_item.dart';
import 'package:supermarket/features/favorite/presentation/widgets/custom_fav_default_widget.dart';

import '../../domain/entities/favorite_entities.dart';

class FavViewBody extends StatelessWidget {
  const FavViewBody({super.key, required this.favorite});
  final Favorite favorite;

  @override
  Widget build(BuildContext context) {
    // Check if the favorite list is empty
    if (favorite.products.isEmpty) {
      return const CustomFavDefaultWidget();
    }

    // Display the list of favorite products
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: favorite.products.length,
      itemBuilder: (context, index) {
        final product = favorite.products[index];
        return CustomFavItem(product: product);
      },
    );
  }
}
