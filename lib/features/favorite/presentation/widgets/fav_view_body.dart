import 'package:flutter/material.dart';
import 'package:supermarket/features/favorite/presentation/widgets/custom_fav_item.dart';

class FavViewBody extends StatelessWidget {
  final  products;
  const FavViewBody({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFavItem(product: products);
  }
}
