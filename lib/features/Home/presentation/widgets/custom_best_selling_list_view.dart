import 'package:flutter/material.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_best_seller_widget.dart';

class CustomBestSellingListView extends StatelessWidget {
  const CustomBestSellingListView({super.key,required this.product});
  final List product;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: product.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: CustomBestSellerWidget(product: product[index]),
      );
    },);
  }
}