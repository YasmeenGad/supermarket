import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:supermarket/features/Home/presentation/widgets/custom_overlay.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_product_details.dart';

import 'package:supermarket/features/cart/presentation/bloc/create_order_bloc/create_order_bloc.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_text_bar.dart';

class ProductDetailsView extends StatefulWidget {
  final dynamic products;

  ProductDetailsView({super.key, this.products});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  bool _showLoading = false;
  bool _showSuccessAnimation = false;

  void _showSuccess() {
    setState(() {
      _showSuccessAnimation = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _showSuccessAnimation = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomTextBar(
        text: "Product Details",
      ),
      body: BlocListener<CreateOrderBloc, CreateOrderState>(
        listener: (context, state) {
          if (state is CreateOrderLoading) {
            setState(() {
              _showLoading = true;
            });
          } else if (state is CreateOrderSuccess) {
            setState(() {
              _showLoading = false;
              _showSuccess();
            });
          } else if (state is CreateOrderError) {
            setState(() {
              _showLoading = false;
            });
                      // Dismiss the loading Snackbar
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          // Show an error Snackbar
          final snackBar = SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 10),
                Text('${state.message}'),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Stack(
          children: [
            CustomProductDetails(
              products: widget.products,
            ),
            if (_showLoading || _showSuccessAnimation)
              CustomOverlay(
                showLoading: _showLoading,
              )
          ],
        ),
      ),
    );
  }
}
