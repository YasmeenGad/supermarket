import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/core/widgets/custom_loading_indicator.dart';
import 'package:supermarket/features/Home/presentation/views/see_all_products.dart';
import 'package:supermarket/features/explore/presentation/bloc/categoruBloc/category_bloc.dart';
import 'package:supermarket/features/explore/presentation/widgets/custom_category_widget.dart';
import 'package:supermarket/features/filter/domain/entities/filtered_products.dart';
import 'package:supermarket/features/filter/presentation/bloc/filtered_products_bloc/filtered_products_bloc.dart';
import 'package:supermarket/features/search/presentation/bloc/search_category_bloc/search_category_bloc.dart';

class AllCategoriesView extends StatefulWidget {
  const AllCategoriesView({super.key});

  @override
  State<AllCategoriesView> createState() => _AllCategoriesViewState();
}

class _AllCategoriesViewState extends State<AllCategoriesView> {
  final List<Color> colors = [
    Color(0xffF7A593).withOpacity(0.5),
    Color(0xffD3B0E0).withOpacity(0.5),
    Color(0xff53B175).withOpacity(0.5),
    Color(0xffF8A44C).withOpacity(0.5),
    Color(0xffFDE598).withOpacity(0.5),
    Color(0xffB7DFF5).withOpacity(0.5),
  ];
  final List<Widget> categoryImages = [
    Image.asset(Assets.imagesFruits),
    Image.asset(Assets.imagesMeat),
    Image.asset(Assets.imagesEggs),
    Image.asset(Assets.imagesBeverages),
    Image.asset(Assets.imagesVegetables),
    Image.asset(Assets.imagesBakery),
  ];

  final TextEditingController textController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    textController.removeListener(_onTextChanged);
    textController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onTextChanged() {
    if (_debounceTimer != null && _debounceTimer!.isActive) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(Duration(milliseconds: 300), () {
      if (textController.text.isEmpty) {
        context.read<SearchCategoryBloc>().add(ClearSearchEvent());
      } else {
        context
            .read<SearchCategoryBloc>()
            .add(GetCategoryEvent(categoryName: textController.text.trim()));
      }
    });
  }

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
                  Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: Text('Find Products',
                          style: AppStyles.styleBold20(context)
                              .copyWith(color: darkColor)),
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 51,
                    decoration: BoxDecoration(
                      color: bgTextFieldColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        onChanged: (value) {
                          _onTextChanged();
                        },
                        controller: textController,
                        style: AppStyles.styleMedium14(context)
                            .copyWith(color: darkColor),
                        cursorColor: darkColor,
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {
                              context.read<SearchCategoryBloc>().add(
                                  GetCategoryEvent(
                                      categoryName:
                                          textController.text.trim()));
                            },
                            child:
                                Icon(CupertinoIcons.search, color: darkColor),
                          ),
                          border: InputBorder.none,
                          hintText: 'Search store',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            BlocBuilder<SearchCategoryBloc, SearchCategoryState>(
              builder: (context, state) {
                if (state is SearchCategoryLoading) {
                  return SliverToBoxAdapter(
                    child: CustomLoadingIndicator(),
                  );
                } else if (state is SearchCategoryLoaded) {
                  return SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.95,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return CustomCategoryWidget(
                          color: colors[index],
                          categoryName: state.category.categoryName,
                          categoryImage: categoryImages[index],
                        );
                      },
                      childCount: 1,
                    ),
                  );
                } else if (state is SearchCategoryError) {
                  return BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryLoading) {
                        return SliverToBoxAdapter(
                          child: CustomLoadingIndicator(),
                        );
                      } else if (state is CategoryLoaded) {
                        return SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.95,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return CustomCategoryWidget(
                                color: colors[index],
                                categoryName:
                                    state.categories[index].categoryName,
                                categoryImage: categoryImages[index],
                              );
                            },
                            childCount: categoryImages.length,
                          ),
                        );
                      } else if (state is CategoryError) {
                        return SliverToBoxAdapter(
                          child: Center(child: Text(state.message)),
                        );
                      } else {
                        return SliverToBoxAdapter(child: const SizedBox());
                      }
                    },
                  );
                } else {
                  return BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryLoading) {
                        return SliverToBoxAdapter(
                          child: CustomLoadingIndicator(),
                        );
                      } else if (state is CategoryLoaded) {
                        return SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.95,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return CustomCategoryWidget(
                                color: colors[index],
                                categoryName:
                                    state.categories[index].categoryName,
                                categoryImage: categoryImages[index],
                              );
                            },
                            childCount: categoryImages.length,
                          ),
                        );
                      } else if (state is CategoryError) {
                        return SliverToBoxAdapter(
                          child: Center(child: Text(state.message)),
                        );
                      } else {
                        return SliverToBoxAdapter(child: const SizedBox());
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
