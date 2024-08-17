import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_list_tile_product_details.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_product_details_image.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_quantity.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_review.dart';
import 'package:supermarket/features/cart/presentation/bloc/create_order_bloc/create_order_bloc.dart';

class CustomProductDetails extends StatelessWidget {
  const CustomProductDetails({super.key, this.products});
  final dynamic products;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomProductDetailsImage(image: "${products.photo}"),
                CustomListTileProductDetails(
                  productName: products.productName,
                  productDetails: products.productDetail,
                  productId: products.id,
                ),
                SizedBox(height: 25),
                CustomQuantity(
                  price: "${products.price}",
                  quantity: products.quantity,
                  productId: products.id,
                ),
                SizedBox(height: 16),
                Divider(thickness: 1, height: 12),
                SizedBox(height: 16),
                Text(
                  "Product Details",
                  style: AppStyles.styleSemiBold20(context)
                      .copyWith(color: darkColor),
                ),
                Text(
                  "Enjoy top quality and fresh taste with this product. Perfect for enhancing your meals and boosting your nutrition. Selected from the best suppliers for your satisfaction.",
                  style: AppStyles.styleMedium13(context)
                      .copyWith(color: secondaryColor),
                ),
                SizedBox(height: 16),
                Divider(thickness: 1, height: 12),
                SizedBox(height: 16),
                CustomReview(rate: products.rate),
                SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    context
                        .read<CreateOrderBloc>()
                        .add(CreateOrder([products.id]));
                  },
                  child: CustomButton(text: "Add To Basket"),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
