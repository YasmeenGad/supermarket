import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/favorite/presentation/bloc/add_faorite_bloc/add_favorite_bloc.dart';
import 'package:supermarket/features/favorite/presentation/views/fav_view.dart'; // Import the FavoriteView

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
    return BlocListener<AddFavoriteBloc, AddFavoriteState>(
      listener: (context, state) {
        if (state is AddFavoriteLoading) {
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
        } else if (state is AddFavoriteSuccess) {
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
              label: 'UNDO',
              textColor: Colors.white,
              onPressed: () {
                // Handle UNDO action
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          // Navigate to the FavoriteView
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavView(productId: state.favorites.id,)),
          );
        } else if (state is AddFavoriteError) {
          // Dismiss the loading Snackbar
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          // Show an error Snackbar
          final snackBar = SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 10),
                Text('Failed to add to favorites!'),
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
                  context.read<AddFavoriteBloc>().add(AddFavorite([productId]));
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
