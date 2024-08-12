import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_list_tile.dart';
import 'package:supermarket/features/favorite/presentation/bloc/add_fav_products/add_favorite_product_bloc.dart';
import 'package:supermarket/features/favorite/presentation/bloc/get_fav_products/get_favorite_products_bloc.dart';

class CustomListTileProductDetails extends StatelessWidget {
  final String productName;
  final String productDetails;
  final String productId;

  const CustomListTileProductDetails({
    Key? key,
    required this.productName,
    required this.productDetails,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddFavoriteProductBloc, AddFavoriteProductState>(
        listener: (context, state) {
          if (state is AddFavoriteProductLoading) {
            _showLoadingSnackbar(context);
          } else if (state is AddFavoriteProductSuccess) {
            _handleSuccess(context);
          } else if (state is AddFavoriteProductFailure) {
            _showErrorSnackbar(context, state.message);
          }
        },
        child: CustomListTile(
          productDetails: productDetails,
          productName: productName,
          productId: productId,
        ));
  }

  void _showLoadingSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
          const SizedBox(width: 15),
          const Text('Adding to favorites...'),
        ],
      ),
      backgroundColor: Colors.blueAccent,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(days: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _handleSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white),
          const SizedBox(width: 10),
          const Text('Added to favorites successfully!'),
        ],
      ),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    context.read<GetFavoriteProductsBloc>().add(GetFavoriteProducts());
    Navigator.pushNamed(context, AppRoutes.favRoute);
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(Icons.error, color: Colors.white),
          const SizedBox(width: 10),
          Text(message),
        ],
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
