import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/search/presentation/bloc/search_product_bloc/search_product_bloc.dart';

class CustomResultHeader extends StatelessWidget {
  const CustomResultHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchProductBloc, SearchProductState>(
      builder: (context, state) {
        if (state is SearchProductLoaded && state.products.isNotEmpty) {
          return Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                "Results",
                style:
                    AppStyles.styleBold20(context).copyWith(color: darkColor),
              ),
            ),
          );
        } else {
          return SizedBox.shrink(); // Empty container when no results
        }
      },
    );
  }
}
