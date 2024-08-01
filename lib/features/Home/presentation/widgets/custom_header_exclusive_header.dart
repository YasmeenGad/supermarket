import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/Home/presentation/bloc/all_product_bloc/all_products_bloc_bloc.dart';
import 'package:supermarket/features/Home/presentation/views/see_all_products.dart';

class CustomHeaderExclusiveHeader extends StatelessWidget {
  const CustomHeaderExclusiveHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              "Exclusive Offer",
              style:
                  AppStyles.styleSemiBold24(context).copyWith(color: darkColor),
            )),
        Expanded(child: SizedBox()),
        FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                // Dispatch the event to fetch all products
                final allProductsState =
                    context.read<AllProductsBlocBloc>().state;
                if (allProductsState is AllProductsBlocLoaded) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeeAllProducts(
                        products: allProductsState.products,
                        title: 'Exclusive Offer',
                      ),
                    ),
                  );
                }
              },
              child: Text(
                "see all",
                style: AppStyles.styleSemiBold16(context)
                    .copyWith(color: primaryColor),
              ),
            )),
      ],
    );
  }
}
