import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/Home/presentation/bloc/BestSellingProducts/best_selling_products_bloc.dart';
import 'package:supermarket/features/Home/presentation/views/see_all_products.dart';

class CustomHeaderBestSelling extends StatelessWidget {
  const CustomHeaderBestSelling({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
                      children: [
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Best Selling",
                              style: AppStyles.styleSemiBold24(context)
                                  .copyWith(color: darkColor),
                            )),
                        Expanded(child: SizedBox()),
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                // Dispatch the event to fetch best selling products
                                final allProductsState = context
                                    .read<BestSellingProductsBloc>()
                                    .state;
                                if (allProductsState
                                    is BestSellingProductsLoaded) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SeeAllProducts(
                                        products: allProductsState.products,
                                        title: 'Best Selling',
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