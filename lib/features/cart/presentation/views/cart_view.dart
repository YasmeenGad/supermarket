import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/core/widgets/custom_awesome_dialog.dart';
import 'package:supermarket/core/widgets/custom_loading_indicator.dart';
import 'package:supermarket/features/cart/presentation/bloc/create_order_bloc/create_order_bloc.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_text_bar.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomTextBar(
        text: "My Cart",
      ),
      body: BlocBuilder<CreateOrderBloc, CreateOrderState>(
        builder: (context, state) {
          if (state is CreateOrderLoading) {
            return CustomLoadingIndicator();
          } else if (state is CreateOrderSuccess) {
            return Text("Success");
          } else if (state is CreateOrderError) {
            return Text("${state.message}");
          }
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Assets.imagesEmptycart),
                      Text("Your cart is empty",
                          style: AppStyles.styleSemiBold18(context)
                              .copyWith(color: darkColor)),
                      Text(
                          "Look like you haven't added\n   anything to your cart yet",
                          style: AppStyles.styleMedium14(context)
                              .copyWith(color: secondaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
