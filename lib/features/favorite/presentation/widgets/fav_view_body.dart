import 'package:flutter/material.dart';
import 'package:supermarket/features/favorite/presentation/widgets/custom_fav_item.dart';

class FavViewBody extends StatelessWidget {
  final  products;
  final VoidCallback onDelete;
  const FavViewBody({
    super.key,
    required this.products,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFavItem(product: products, onDelete: onDelete,);
  }
}
