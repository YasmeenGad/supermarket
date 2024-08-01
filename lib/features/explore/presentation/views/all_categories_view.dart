import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/widgets/custom_loading_indicator.dart';
import 'package:supermarket/features/explore/presentation/bloc/categoruBloc/category_bloc.dart';
import 'package:supermarket/features/explore/presentation/widgets/custom_category_content.dart';
import 'package:supermarket/features/explore/presentation/widgets/custom_category_grid.dart';
import 'package:supermarket/features/explore/presentation/bloc/search_category_bloc/search_category_bloc.dart';
import 'package:supermarket/features/explore/presentation/widgets/custom_category_search_field.dart';
import 'package:supermarket/features/explore/presentation/widgets/custom_text_find_products.dart';

class AllCategoriesView extends StatefulWidget {
  const AllCategoriesView({super.key});

  @override
  State<AllCategoriesView> createState() => _AllCategoriesViewState();
}

class _AllCategoriesViewState extends State<AllCategoriesView> {
  @override
  void didChangeDependencies() {
    context.read<CategoryBloc>().add(GetCategoriesEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 48.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  CustomTextFindProducts(),
                  const SizedBox(height: 12),
                  CustomCategorySearchField(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            BlocBuilder<SearchCategoryBloc, SearchCategoryState>(
              builder: (context, state) {
                if (state is SearchCategoryLoading) {
                  return const SliverToBoxAdapter(
                      child: CustomLoadingIndicator());
                } else if (state is SearchCategoryLoaded) {
                  return CustomCategoryGrid([state.category]);
                } else if (state is SearchCategoryError ||
                    state is SearchCategoryInitial) {
                  return CustomCategoryContent();
                } else {
                  return const SliverToBoxAdapter(child: SizedBox());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
