import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
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
          return Row(
            children: [
              Expanded(
                flex: 3,
                child: CustomButton(
                  text: "Go To Checkout",
                  price: totalPrice,
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 67,
                    decoration: BoxDecoration(
                      // color: secondaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Total",
                            style: AppStyles.styleRegular20(context)
                                .copyWith(color: darkColor)),
                        Text("\$ $totalPrice",
                            style: AppStyles.styleMedium18(context)
                                .copyWith(color: primaryColor)),
                      ],
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }
}
