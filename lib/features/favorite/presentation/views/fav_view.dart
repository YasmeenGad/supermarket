import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_text_bar.dart';
import 'package:supermarket/features/favorite/presentation/bloc/delete_all_fav/delete_all_favorite_products_bloc.dart';
import 'package:supermarket/features/favorite/presentation/bloc/delete_one_fav_products/delete_one_favorite_product_bloc.dart';
import 'package:supermarket/features/favorite/presentation/bloc/get_fav_products/get_favorite_products_bloc.dart';
import 'package:supermarket/features/favorite/presentation/widgets/custom_fav_default_widget.dart';
import 'package:supermarket/features/favorite/presentation/widgets/fav_view_body.dart';

class FavView extends StatefulWidget {
  const FavView({Key? key}) : super(key: key);

  @override
  _FavViewState createState() => _FavViewState();
}

class _FavViewState extends State<FavView> {
  bool hasShownSuccessSnackbar = false;
  final _snackbarMessages = <String>{};

  @override
  void initState() {
    super.initState();
    _loadFavoriteProducts();
  }

  void _loadFavoriteProducts() {
    context.read<GetFavoriteProductsBloc>().add(GetFavoriteProducts());
  }

  void _onProductDeleted() {
    _loadFavoriteProducts();
    hasShownSuccessSnackbar =
        false; // Reset flag when refreshing the product list
  }

  void _deleteAllFavorites() {
    context
        .read<DeleteAllFavoriteProductsBloc>()
        .add(DeleteAllFavoriteProductsItemEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomTextBar(text: 'Favorite'),
      body: BlocConsumer<GetFavoriteProductsBloc, GetFavoriteProductsState>(
        listener: (context, state) {
          if (state is GetFavoriteProductsError) {
            _showErrorSnackbar(state.message);
          }
        },
        builder: (context, state) {
          if (state is GetFavoriteProductsLoading) {
            return _buildLoadingIndicator();
          } else if (state is GetFavoriteProductsSuccess) {
            if (state.favorites.products.isEmpty) {
              return const CustomFavDefaultWidget();
            } else {
              return _buildProductList(state.favorites.products);
            }
          } else if (state is GetFavoriteProductsError) {
            return _buildErrorText(state.message);
          }
          return const CustomFavDefaultWidget();
        },
      ),
      floatingActionButton:
          BlocBuilder<GetFavoriteProductsBloc, GetFavoriteProductsState>(
        builder: (context, state) {
          bool hasFavorites = false;
          if (state is GetFavoriteProductsSuccess) {
            hasFavorites = state.favorites.products.isNotEmpty;
          }
          return Offstage(
            offstage: !hasFavorites,
            child: FloatingActionButton.extended(
              onPressed: _deleteAllFavorites,
              label: Text(
                'Delete All',
                style: AppStyles.styleMedium16(context)
                    .copyWith(color: Colors.white),
              ),
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              tooltip: 'Delete all favorite products',
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildProductList(List<dynamic> products) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return BlocConsumer<DeleteOneFavoriteProductBloc,
            DeleteOneFavoriteProductState>(
          listener: (context, deleteState) {
            if (deleteState is DeleteOneFavoriteProductSuccess) {
              final message = 'Product removed successfully!';
              if (!_snackbarMessages.contains(message)) {
                _showSuccessSnackbar(message);
                _snackbarMessages.add(message); // Track shown message
              }
              _onProductDeleted();
            } else if (deleteState is DeleteOneFavoriteProductError) {
              _showErrorSnackbar(deleteState.message);
            }
          },
          builder: (context, deleteState) {
            return FavViewBody(
              products: product,
              onDelete: () {
                context.read<DeleteOneFavoriteProductBloc>().add(
                      DeleteOneFavoriteProductItem(id: [product.id]),
                    );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildErrorText(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8.0),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(16.0),
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8.0),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(8),
        action: SnackBarAction(
          label: 'Ok',
          textColor: Colors.white,
          onPressed: () {
            // Add undo functionality if needed
          },
        ),
      ),
    );
  }
}
