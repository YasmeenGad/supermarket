import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/widgets/custom_loading_indicator.dart';
import 'package:supermarket/features/Home/presentation/widgets/exclusive_offer_widget.dart';
import 'package:supermarket/features/filter/presentation/bloc/filtered_products_bloc/filtered_products_bloc.dart';

class FilteredProductsViewBody extends StatefulWidget {
  const FilteredProductsViewBody({required this.categoryName});
  final String categoryName;

  @override
  State<FilteredProductsViewBody> createState() =>
      _FilteredProductsViewBodyState();
}

class _FilteredProductsViewBodyState extends State<FilteredProductsViewBody> {
  @override
  void didChangeDependencies() {
    context
        .read<FilteredProductsBloc>()
        .add(GetProductsByCategoryEvent(categoryName: widget.categoryName));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: BlocBuilder<FilteredProductsBloc, FilteredProductsState>(
            builder: (context, state) {
              if (state is FilteredProductsLoading) {
                return CustomLoadingIndicator();
              } else if (state is FilteredProductsLoaded) {
                return GridView.builder(
                  itemCount: state.products.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 0.70,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.productDeatailsRoute,
                            arguments: state.products[index]);
                      },
                      child: ExclusiveOfferWidget(
                        product: state.products[index],
                      ),
                    );
                  },
                );
              } else if (state is FilteredProductsError) {
                return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: Text(state.message)));
              } else {
                return SizedBox();
              }
            },
          ))
        ],
      ),
    );
  }
}
