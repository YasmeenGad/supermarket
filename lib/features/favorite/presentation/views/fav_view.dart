import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_text_bar.dart';
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
  final Set<String> _snackbarMessages = {};

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
    hasShownSuccessSnackbar = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomTextBar(text: 'Favorite'),
      body: BlocConsumer<GetFavoriteProductsBloc, GetFavoriteProductsState>(
        listener: _favoriteProductsListener,
        builder: _favoriteProductsBuilder,
      ),
    );
  }

  void _favoriteProductsListener(BuildContext context, GetFavoriteProductsState state) {
    if (state is GetFavoriteProductsError) {
      _showErrorSnackbar(state.message);
    }
  }

  Widget _favoriteProductsBuilder(BuildContext context, GetFavoriteProductsState state) {
    if (state is GetFavoriteProductsLoading) {
      return _buildLoadingIndicator();
    } else if (state is GetFavoriteProductsSuccess) {
      return state.favorites.products.isEmpty
          ? const CustomFavDefaultWidget()
          : _buildProductList(state.favorites.products);
    } else if (state is GetFavoriteProductsError) {
      return _buildErrorText(state.message);
    }
    return const CustomFavDefaultWidget();
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
        return BlocConsumer<DeleteOneFavoriteProductBloc, DeleteOneFavoriteProductState>(
          listener: (context, deleteState) {
            if (deleteState is DeleteOneFavoriteProductSuccess) {
              _handleDeleteSuccess();
            } else if (deleteState is DeleteOneFavoriteProductError) {
              _showErrorSnackbar(deleteState.message);
            }
          },
          builder: (context, deleteState) {
            return FavViewBody(
              products: product,
              onDelete: () => _deleteFavoriteProduct(context, product.id),
            );
          },
        );
      },
    );
  }

  void _handleDeleteSuccess() {
    const message = 'Product removed successfully!';
    if (!_snackbarMessages.contains(message)) {
      _showSuccessSnackbar(message);
      _snackbarMessages.add(message);
    }
    _onProductDeleted();
  }

  void _deleteFavoriteProduct(BuildContext context, String productId) {
    context.read<DeleteOneFavoriteProductBloc>().add(DeleteOneFavoriteProductItem(id: [productId]));
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
    _showSnackbar(
      context,
      message: message,
      icon: Icons.check_circle,
      backgroundColor: Colors.green,
    );
  }

  void _showErrorSnackbar(String message) {
    _showSnackbar(
      context,
      message: message,
      icon: Icons.error,
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: 'Ok',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
  }

  void _showSnackbar(BuildContext context,
      {required String message, required IconData icon, required Color backgroundColor, SnackBarAction? action}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8.0),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(16.0),
        action: action,
      ),
    );
  }
}
