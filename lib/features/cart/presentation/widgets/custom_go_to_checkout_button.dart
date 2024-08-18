import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/features/cart/presentation/bloc/get_total_order.dart/get_total_order_bloc.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_list_tile_checkout.dart';

class CustomGoToCheckoutButton extends StatelessWidget {
  const CustomGoToCheckoutButton({super.key, this.state, this.orderId});
  final state;
  final orderId;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 10,
      right: 10,
      child: BlocBuilder<GetTotalOrderBloc, GetTotalOrderState>(
        builder: (context, totalState) {
          final totalPrice = (totalState is GetTotalOrderSuccess)
              ? totalState.totalOrder.totalPrice
              : 0.0;
          final totalQuantity = (totalState is GetTotalOrderSuccess)
              ? totalState.totalOrder.totalAmount
              : 0;

          return GestureDetector(
            onTap: () {
              showFriendlyBottomSheet(context, totalPrice, totalQuantity);
            },
            child: CustomButton(
              text: "Go To Checkout",
            ),
          );
        },
      ),
    );
  }

  void showFriendlyBottomSheet(
      BuildContext context, double totalPrice, int totalQuantity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30), // Friendly rounded corners
        ),
      ),
      backgroundColor: Colors.white, // Clean, friendly background
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Checkout',
                      style: AppStyles.styleSemiBold24(context).copyWith(
                        color: darkColor, // Neutral color for text
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: darkColor,
                        size: 28, // Larger icon for ease of use
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16), // Space between header and content
              Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.paymentDetailsRoute);
                },
                child: CustomListTileCheckout(
                  title: "Payment Methods",
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              CustomListTileCheckout(
                title: "Total Cost",
                trailing: Text(
                  "${totalPrice} EGP",
                  style: AppStyles.styleMedium18(context)
                      .copyWith(color: primaryColor),
                ),
              ),
              const SizedBox(height: 12),
              CustomListTileCheckout(
                title: "Total Amount",
                trailing: Text(
                  "${totalQuantity} Products",
                  style: AppStyles.styleMedium18(context)
                      .copyWith(color: primaryColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
