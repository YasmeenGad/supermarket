import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/favorite/presentation/bloc/add_fav_products/add_favorite_product_bloc.dart';
import 'package:supermarket/features/favorite/presentation/bloc/get_fav_products/get_favorite_products_bloc.dart';

class CustomListTileProductDetails extends StatelessWidget {
  const CustomListTileProductDetails(
      {super.key,
      required this.productName,
      required this.productDetails,
      required this.productId});
  final String productName;
  final String productDetails;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddFavoriteProductBloc, AddFavoriteProductState>(
      listener: (context, state) {
        if (state is AddFavoriteProductLoading) {
          // Show a loading Snackbar
          final snackBar = SnackBar(
            content: Row(
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                SizedBox(width: 15),
                Text('Adding to favorites...'),
              ],
            ),
            backgroundColor: Colors.blueAccent,
            behavior: SnackBarBehavior.floating,
            duration: Duration(days: 1), // Will be dismissed programmatically
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is AddFavoriteProductSuccess) {
          // Dismiss the loading Snackbar
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          // Show a success Snackbar
          final snackBar = SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 10),
                Text('Added to favorites successfully!'),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            action: SnackBarAction(
              label: 'OK',
              textColor: Colors.white,
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          context
              .read<GetFavoriteProductsBloc>()
              .add(GetFavoriteProducts(id: state.addFavorite.id));
          // Navigate to the FavoriteView
          Navigator.pushNamed(context, AppRoutes.favRoute);
        } else if (state is AddFavoriteProductFailure) {
          // Dismiss the loading Snackbar
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          // Show an error Snackbar
          final snackBar = SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 10),
                Text('${state.message}'),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    productName,
                    style: AppStyles.styleBold24(context)
                        .copyWith(color: blackColor),
                  )),
              subtitle: Text(
                "$productDetails, Price",
                maxLines: 2,
                style: AppStyles.styleMedium16(context)
                    .copyWith(color: secondaryColor),
              ),
              trailing: GestureDetector(
                onTap: () {
                  context
                      .read<AddFavoriteProductBloc>()
                      .add(AddFavoriteProduct(productIds: [productId]));
                },
                child: Icon(
                  Icons.favorite_outline,
                  color: darkColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
