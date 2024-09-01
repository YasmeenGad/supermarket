import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/features/cart/presentation/bloc/get_order_bloc/get_order_bloc.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_cart_view_body.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_text_bar.dart';
import 'package:supermarket/features/checkout/domain/entities/create_customer.dart';

class CartView extends StatefulWidget {
  const CartView({super.key,  this.customer});
  final Customer? customer;

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
        body: CustomCartViewBody(customer: widget.customer,));
  }
}
