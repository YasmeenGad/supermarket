import 'package:flutter/material.dart';
import 'package:supermarket/features/favorite/domain/entities/fav_products.dart';

import 'package:supermarket/features/favorite/presentation/widgets/custom_fav_item.dart';

class FavViewBody extends StatelessWidget {
  const FavViewBody({super.key, required this.favorite});
  final Favorite favorite;

  @override
  Widget build(BuildContext context) {
    return CustomFavItem(favorite: favorite,);
  }
}
