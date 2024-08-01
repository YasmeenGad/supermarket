import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/widgets/custom_loading_indicator.dart';
import 'package:supermarket/features/cart/presentation/bloc/get_total_order.dart/get_total_order_bloc.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_cart_item.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_total_order_error.dart';

class CustomCartList extends StatelessWidget {
  const CustomCartList(this.state);
  final state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTotalOrderBloc, GetTotalOrderState>(
      builder: (context, totalState) {
        if (totalState is GetTotalOrderLoading) {
          return const Center(child: CustomLoadingIndicator());
        } else if (totalState is GetTotalOrderSuccess) {
          return CustomScrollView(
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
          );
        } else if (totalState is GetTotalOrderError) {
          return CustomTotalOrderError(totalState.message);
        }
        return Container();
      },
    );
  }
}
