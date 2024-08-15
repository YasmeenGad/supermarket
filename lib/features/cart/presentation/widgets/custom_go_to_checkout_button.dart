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
          final totalQuantity = (totalState is GetTotalOrderSuccess)?
              totalState.totalOrder.totalAmount: 0;

          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled:
                    true, // Allows the sheet to take full height
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                builder: (context) {
                  return Container(
                    width: MediaQuery.sizeOf(context).width,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(
                              'Checkout',
                              style: AppStyles.styleSemiBold24(context)
                                  .copyWith(color: darkColor),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close,
                                color: darkColor,
                              ),
                            ),
                          ),
                          Divider(
                            endIndent: 20,
                            indent: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.paymentDetailsRoute);
                            },
                            child: CustomListTileCheckout(
                              title: "Payment",
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                          Divider(
                            endIndent: 20,
                            indent: 20,
                          ),
                          CustomListTileCheckout(
                            title: "Total Cost",
                            trailing: Text(
                              "${totalPrice} EGP",
                              style: AppStyles.styleMedium18(context),
                            ),
                          ),
                          Divider(
                            endIndent: 20,
                            indent: 20,
                          ),
                          CustomListTileCheckout(
                            title: "Total Amount",
                            trailing: Text(
                              "${totalQuantity} Products",
                              style: AppStyles.styleMedium18(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: CustomButton(
              text: "Go To Checkout",
              price: totalPrice,
            ),
          );
        },
      ),
    );
  }
}
