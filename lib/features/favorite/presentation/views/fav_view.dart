import 'package:flutter/material.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_text_bar.dart';

class FavView extends StatefulWidget {
  final String productId;

  const FavView({super.key, required this.productId});

  @override
  State<FavView> createState() => _FavViewState();
}

class _FavViewState extends State<FavView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomTextBar(text: 'Favorite'),
    );
  }
}
