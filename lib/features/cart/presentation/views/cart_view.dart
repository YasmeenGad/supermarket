import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/core/widgets/custom_awesome_dialog.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/core/widgets/custom_loading_indicator.dart';
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
            BlocBuilder<GetOrderBloc, GetOrderState>(
              builder: (context, state) {
                if (state is GetOrderLoading) {
                  return CustomLoadingIndicator();
                } else if (state is GetOrderSuccess) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 80.0), // Adjust the padding to fit the button
                        child: CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return CustomCartItem(
                                    order: state.orders.products[index],
                                  );
                                },
                                childCount: state.orders.products.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: CustomButton(text: "Go To Checkout"),
                      ),
                    ],
                  );
                } else if (state is GetOrderError) {
                  // Show error dialog after the build is complete
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    CustomAwesomDialog.showErrorDialog(context, state.message);
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
          ],
        ),
      ),
    );
  }
}
