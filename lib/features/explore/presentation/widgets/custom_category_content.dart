import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/widgets/custom_loading_indicator.dart';
import 'package:supermarket/features/explore/presentation/bloc/categoruBloc/category_bloc.dart';
import 'package:supermarket/features/explore/presentation/widgets/custom_category_grid.dart';

class CustomCategoryContent extends StatelessWidget {
  const CustomCategoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const SliverToBoxAdapter(child: CustomLoadingIndicator());
        } else if (state is CategoryLoaded) {
          return CustomCategoryGrid(state.categories);
        } else if (state is CategoryError) {
          return SliverToBoxAdapter(
            child: Center(child: Text(state.message)),
          );
        } else {
          return const SliverToBoxAdapter(child: SizedBox());
        }
      },
    );
  }
}
