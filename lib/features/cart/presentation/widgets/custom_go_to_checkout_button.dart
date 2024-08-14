import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/features/cart/presentation/bloc/get_total_order.dart/get_total_order_bloc.dart';

class CustomGoToCheckoutButton extends StatelessWidget {
  const CustomGoToCheckoutButton({super.key, this.state});
  final state;

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
          return Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.paymentDetailsRoute);
              },
              child: CustomButton(
                text: "Go To Checkout",
                price: totalPrice,
              ),
            ),
          );
        },
      ),
    );
  }
}
