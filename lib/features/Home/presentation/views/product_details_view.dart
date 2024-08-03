import 'package:flutter/cupertino.dart';
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

class ProductDetailsView extends StatefulWidget {
  ProductDetailsView({super.key, this.products});
  final dynamic products;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  bool _showSuccessAnimation = false;

  void _showAnimation() {
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
    print(widget.products);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 25,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.cart,
                color: darkColor,
                size: 30,
              )),
          SizedBox(
            width: 8,
          ),
        ],
      ),
      body: BlocListener<CreateOrderBloc, CreateOrderState>(
        listener: (context, state) {
          if (state is CreateOrderSuccess) {
            _showAnimation();
          }
          // Handle other states if needed
        },
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomProductDetailsImage(
                        image: "${widget.products.photo}",
                      ),
                      CustomListTileProductDetails(
                        productName: widget.products.productName,
                        productDetails: widget.products.productDetail,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomQuantity(
                        price: "${widget.products.price}",
                        quantity: widget.products.quantity,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Divider(
                        thickness: 1,
                        height: 12,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
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
                      const SizedBox(
                        height: 16,
                      ),
                      const Divider(
                        thickness: 1,
                        height: 12,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomReview(rate: widget.products.rate),
                      const SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                          onTap: () {
                            context
                                .read<CreateOrderBloc>()
                                .add(CreateOrder([widget.products.id]));
                          },
                          child: CustomButton(text: "Add To Basket")),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ))
              ],
            ),
            Center(
              child: AnimatedOpacity(
                opacity: _showSuccessAnimation ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 100,
                    ),
                    Text(
                      "Added To Cart Successfully",
                      style: AppStyles.styleSemiBold20(context)
                          .copyWith(color: primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
