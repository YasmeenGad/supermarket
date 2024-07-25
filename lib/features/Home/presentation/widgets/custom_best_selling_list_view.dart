import 'package:flutter/material.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_best_seller_widget.dart';

class CustomBestSellingListView extends StatelessWidget {
  const CustomBestSellingListView({super.key,required this.product, this.physics});
  final List product;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: product.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: physics ?? NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, AppRoutes.productDeatailsRoute,arguments: product[index]);
          },
          child: CustomBestSellerWidget(product: product[index])),
      );
    },);
  }
}