import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/features/explore/presentation/bloc/categoruBloc/category_bloc.dart';
import 'package:supermarket/features/explore/presentation/widgets/custom_category_widget.dart';
import 'package:supermarket/features/explore/presentation/widgets/custom_search_category_section.dart';

class AllCategoriesView extends StatefulWidget {
  const AllCategoriesView({super.key});

  @override
  State<AllCategoriesView> createState() => _AllCategoriesViewState();
}

class _AllCategoriesViewState extends State<AllCategoriesView> {
  final List<Color> colors = [
    Color(0xff53B175).withOpacity(0.5),
    Color(0xffF8A44C).withOpacity(0.5),
    Color(0xffF7A593).withOpacity(0.5),
    Color(0xffD3B0E0).withOpacity(0.5),
    Color(0xffFDE598).withOpacity(0.5),
  ];
  final List<Widget> categoryImages = [
    Image.asset("${Assets.imagesMeat}"),
    Image.asset("${Assets.imagesEggs}"),
    Image.asset("${Assets.imagesBeverages}"),
    Image.asset("${Assets.imagesFruits}"),
    Image.asset("${Assets.imagesVegetables}"),
  ];

  @override
  void didChangeDependencies() {
    // dispatch event to get all categories
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
                child: CustomSearchCategorySection(),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.95,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) {
                      if (state is CategoryLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        );
                      } else if (state is CategoryLoaded) {
                        return CustomCategoryWidget(
                          color: colors[index],
                          categoryName: state.categories[index].categoryName,
                          categoryImage: categoryImages[index],
                        );
                      } else if (state is CategoryError) {
                        return Center(
                          child: Text("${state.message}"),
                        );
                      } else {
                        return const SizedBox();
                      }
                    });
                  },
                  childCount: categoryImages.length,
                ),
              ),
            ],
          )),
    );
  }
}
