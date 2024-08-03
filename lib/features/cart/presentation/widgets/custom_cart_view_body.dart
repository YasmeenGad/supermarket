import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/widgets/custom_awesome_dialog.dart';
import 'package:supermarket/core/widgets/custom_loading_indicator.dart';
import 'package:supermarket/features/cart/presentation/bloc/get_total_order.dart/get_total_order_bloc.dart';
import 'package:supermarket/features/cart/presentation/bloc/get_order_bloc/get_order_bloc.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_cart_container.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_cart_list.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_container_internet_connection.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_empty_cart_content.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_go_to_checkout_button.dart';

class CustomCartViewBody extends StatelessWidget {
  const CustomCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CartContainer(
      child: BlocListener<GetOrderBloc, GetOrderState>(
        listener: (context, state) {
          if (state is GetOrderSuccess) {
            if (state.orders.products.isNotEmpty) {
              _fetchTotalOrder(context, state.orders.id);
            }
          }
        },
        child: BlocBuilder<GetOrderBloc, GetOrderState>(
          builder: (context, state) {
            if (state is GetOrderLoading) {
              return const Center(child: CustomLoadingIndicator());
            } else if (state is GetOrderSuccess) {
              if (state.orders.products.isEmpty) {
                return CustomEmptyCartContent();
              } else {
                return Stack(
                  children: [
                    CustomCartList(state),
                    if (state.orders.products.isNotEmpty)
                      CustomGoToCheckoutButton(
                        state: state,
                      ),
                  ],
                );
              }
            } else if (state is GetOrderError) {
              if (state.message != "Exception: Order not found") {
              return  CustomContainerInternetConnection(state: "${state.message}",);
              } else {
                return CustomEmptyCartContent();
              }
            } else {
              return CustomEmptyCartContent();
            }
          
          },
        ),
      ),
    );
  }
}

void _fetchTotalOrder(BuildContext context, String orderId) {
  context.read<GetTotalOrderBloc>().add(GetTotalOrder(orderId: orderId));
}

void _showErrorDialog(BuildContext context, String message) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    CustomAwesomDialog.showErrorDialog(context, message);
  });
}
