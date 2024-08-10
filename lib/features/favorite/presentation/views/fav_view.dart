import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/widgets/custom_loading_indicator.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_text_bar.dart';
import 'package:supermarket/features/favorite/presentation/bloc/get_favorite/get_favorite_bloc.dart';
import 'package:supermarket/features/favorite/presentation/widgets/fav_view_body.dart';

class FavView extends StatefulWidget {
  final String productId;

  const FavView({super.key, required this.productId});

  @override
  State<FavView> createState() => _FavViewState();
}

class _FavViewState extends State<FavView> {
  @override
  void initState() {
    super.initState();
    // Fetch favorite products when the view is loaded
    context.read<GetFavoriteBloc>().add(GetFavoriteProducts(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomTextBar(text: 'Favorite'),
      body: BlocBuilder<GetFavoriteBloc, GetFavoriteState>(
  builder: (context, state) {
    if (state is GetFavoriteLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (state is GetFavoriteSuccess) {
      final products = state.favoriteProducts.products;
      
      if (products.isEmpty) {
        return Center(child: Text('No favorite products found. Is Empty'));
      } else {
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Container(
              color: Colors.red,
              height: 200,
              width: 200,
              child: ListTile(
                title: Text(product.productName),
                subtitle: Text('${product.price} \$'),
                leading: Image.network(product.photo),
              ),
            );
          },
        );
      }
    } else if (state is GetFavoriteError) {
      print(state.message);
      return Center(child: Text('Error: ${state.message}'));
    } else {
      return Center(child: Text('No favorite products found.'));
    }
  },
)
    );
  }
}
