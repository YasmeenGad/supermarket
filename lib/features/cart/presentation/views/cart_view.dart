import 'package:flutter/material.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_text_bar.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomTextBar()
    );
  }
}