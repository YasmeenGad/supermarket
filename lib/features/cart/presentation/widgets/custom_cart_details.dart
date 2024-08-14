import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/cart/presentation/bloc/bloc/delete_item_bloc.dart';
import 'package:supermarket/features/cart/presentation/bloc/get_order_bloc/get_order_bloc.dart'; // Assuming you have a CartBloc to manage cart state

class CustomCartDetails extends StatelessWidget {
  const CustomCartDetails({
    super.key,
    required this.productName,
    required this.productDetail,
    required this.productId,
  });

  final String productName;
  final String productDetail;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteItemBloc, DeleteItemState>(
      listener: (context, state) {
        if (state is DeleteItemSuccess) {
          // Show advanced Snackbar on successful delete
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Item deleted successfully!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          );
          // Refresh the cart by adding an event to GetOrderBloc
          context.read<GetOrderBloc>().add(GetOrder());
        }
        if (state is DeleteItemError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error, color: Colors.white),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${state.message}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.redAccent,
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          );
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: AppStyles.styleSemiBold18(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  productDetail,
                  
                  style: AppStyles.styleMedium14(context)
                      .copyWith(color: secondaryColor.withOpacity(0.7)),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              context
                  .read<DeleteItemBloc>()
                  .add(DeleteItem(productId: [productId]));
            },
            icon: Icon(
              Icons.close_rounded,
              color: Colors.redAccent,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
