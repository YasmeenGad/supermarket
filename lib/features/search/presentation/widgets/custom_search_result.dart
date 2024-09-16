import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/core/widgets/custom_loading_indicator.dart';
import 'package:supermarket/features/Home/presentation/widgets/exclusive_offer_widget.dart';
import 'package:supermarket/features/search/presentation/bloc/search_product_bloc/search_product_bloc.dart';

class CustomSearchResult extends StatelessWidget {
  const CustomSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SearchProductBloc, SearchProductState>(
        builder: (context, state) {
          if (state is SearchProductLoading) {
            return const CustomLoadingIndicator();
          } else if (state is SearchProductLoaded) {
            if (state.products.isEmpty) {
              return Center(child: Text("No products found"));
            }
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.productDeatailsRoute,
                    arguments: state.products);
              },
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: state.products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  return ExclusiveOfferWidget(product: state.products[index]);
                },
              ),
            );
          } else if (state is SearchProductError) {
            return Center(child: Text("${state.message}"));
          } else {
            return Center(
              child: Image.asset(
                Assets.imagesSearch,
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.6,
              ),
            );
          }
        },
      ),
    );
  }
}
