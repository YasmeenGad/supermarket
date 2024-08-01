import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/core/widgets/custom_awesome_dialog.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/core/widgets/custom_loading_indicator.dart';
import 'package:supermarket/features/cart/presentation/bloc/bloc/get_total_order_bloc.dart';
import 'package:supermarket/features/cart/presentation/bloc/get_order_bloc/get_order_bloc.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_cart_item.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_text_bar.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<GetOrderBloc>().add(GetOrder());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomTextBar(
        text: "My Cart",
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            BlocListener<GetOrderBloc, GetOrderState>(
              listener: (context, state) {
                if (state is GetOrderSuccess) {
                  final orderId = state.orders.id; // Adjust based on your model
                  context
                      .read<GetTotalOrderBloc>()
                      .add(GetTotalOrder(orderId: orderId));
                }
              },
              child: BlocBuilder<GetOrderBloc, GetOrderState>(
                builder: (context, state) {
                  if (state is GetOrderLoading) {
                    return Center(child: CustomLoadingIndicator());
                  } else if (state is GetOrderSuccess) {
                    return Stack(
                      children: [
                        BlocBuilder<GetTotalOrderBloc, GetTotalOrderState>(
                          builder: (context, totalState) {
                            if (totalState is GetTotalOrderLoading) {
                              return Center(child: CustomLoadingIndicator());
                            } else if (totalState is GetTotalOrderSuccess) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Total Amount: ${totalState.totalOrder.totalAmount}",
                                      style: AppStyles.styleSemiBold18(context)
                                          .copyWith(color: darkColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 80.0),
                                      child: CustomScrollView(
                                        slivers: [
                                          SliverList(
                                            delegate:
                                                SliverChildBuilderDelegate(
                                              (context, index) {
                                                return CustomCartItem(
                                                  order: state
                                                      .orders.products[index],
                                                );
                                              },
                                              childCount:
                                                  state.orders.products.length,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else if (totalState is GetTotalOrderError) {
                              return Center(
                                child: Text(totalState.message,
                                    style: AppStyles.styleMedium18(context)
                                        .copyWith(color: darkColor)),
                              );
                            }
                            return Container();
                          },
                        ),
                        if (state.orders.products.isNotEmpty) // Check if there are products
                          Positioned(
                            bottom: 10,
                            left: 10,
                            right: 10,
                            child: BlocBuilder<GetTotalOrderBloc, GetTotalOrderState>(
                              builder: (context, totalState) {
                                // Handle null price if necessary
                                final totalPrice = (totalState is GetTotalOrderSuccess)
                                    ? totalState.totalOrder.totalPrice
                                    : 0.0;

                                return CustomButton(
                                  text: "Go To Checkout",
                                  price: totalPrice, // Pass the totalPrice
                                );
                              },
                            ),
                          ),
                      ],
                    );
                  } else if (state is GetOrderError) {
                    // Show error dialog after the build is complete
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      CustomAwesomDialog.showErrorDialog(
                          context, state.message);
                    });
                  }

                  return Center(
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(Assets.imagesEmptycart),
                              Text(
                                "Your cart is empty",
                                style: AppStyles.styleSemiBold18(context)
                                    .copyWith(color: darkColor),
                              ),
                              Text(
                                "Look like you haven't added\n   anything to your cart yet",
                                style: AppStyles.styleMedium14(context)
                                    .copyWith(color: secondaryColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
