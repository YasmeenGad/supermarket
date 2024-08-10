import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_text_bar.dart';
import 'package:supermarket/features/favorite/presentation/bloc/get_fav_products/get_favorite_products_bloc.dart';
import 'package:supermarket/features/favorite/presentation/widgets/custom_fav_default_widget.dart';
import 'package:supermarket/features/favorite/presentation/widgets/fav_view_body.dart';

class FavView extends StatefulWidget {
  const FavView({super.key});

  @override
  State<FavView> createState() => _FavViewState();
}

class _FavViewState extends State<FavView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomTextBar(text: 'Favorite'),
      body: BlocBuilder<GetFavoriteProductsBloc, GetFavoriteProductsState>(
        builder: (context, state) {
          if (state is GetFavoriteProductsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetFavoriteProductsSuccess) {
            print(state.favorites.products.length);
            return ListView.builder(
              itemCount: state.favorites.products.length,
              itemBuilder: (context, index) {
                final product = state.favorites.products[index];
                return FavViewBody(
                  products: product,
                );
              },
            );
          } else if (state is GetFavoriteProductsError) {
            print(  state.message);
            return Center(
              child: Text(state.message),
            );
          }
          return CustomFavDefaultWidget();
        },
      ),
    );
  }
}
