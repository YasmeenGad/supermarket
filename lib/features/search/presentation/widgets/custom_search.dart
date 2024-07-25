import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/core/widgets/custom_loading_indicator.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_best_selling_list_view.dart';
import 'package:supermarket/features/search/presentation/bloc/search_product_bloc/search_product_bloc.dart';

class CustomSearch extends StatefulWidget {
  const CustomSearch({Key? key}) : super(key: key);

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  final TextEditingController textController = TextEditingController();
  Timer? _debounceTimer; // Timer for debounce mechanism

  @override
  void initState() {
    super.initState();
    textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    textController.removeListener(_onTextChanged);
    textController.dispose();
    _debounceTimer?.cancel(); // Cancel the debounce timer if widget is disposed
    super.dispose();
  }

  void _onTextChanged() {
    if (_debounceTimer != null && _debounceTimer!.isActive) {
      _debounceTimer!.cancel(); // Cancel previous timer if active
    }

    _debounceTimer = Timer(Duration(milliseconds: 300), () {
      if (textController.text.isEmpty) {
        context.read<SearchProductBloc>().add(ClearSearchEvent());
      } else {
        context
            .read<SearchProductBloc>()
            .add(SearchProduct(query: textController.text.trim()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 45, left: 16, right: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Text('Looking for products',
                    style: AppStyles.styleBold20(context)
                        .copyWith(color: darkColor)),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 51,
              decoration: BoxDecoration(
                  color: bgTextFieldColor,
                  borderRadius: BorderRadius.circular(16)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextField(
                  onChanged: (value) {
                    _onTextChanged(); // Call the debounce function on text change
                  },
                  controller: textController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Store',
                      hintStyle: AppStyles.styleSemiBold16(context)
                          .copyWith(color: secondaryColor),
                      prefixIcon: InkWell(
                        onTap: () {
                          context.read<SearchProductBloc>().add(
                              SearchProduct(
                                  query: textController.text.trim()));
                        },
                        child: Icon(
                          CupertinoIcons.search,
                          color: darkColor,
                        ),
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text("Results",
                    style: AppStyles.styleBold20(context)
                        .copyWith(color: darkColor)),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: BlocBuilder<SearchProductBloc, SearchProductState>(
                  builder: (context, state) {
                if (state is SearchProductLoading) {
                  return const CustomLoadingIndicator();
                } else if (state is SearchProductLoaded) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.productDeatailsRoute,
                          arguments: state.products);
                    },
                    child: CustomBestSellingListView(
                      physics: BouncingScrollPhysics(),
                      product: state.products,
                    ),
                  );
                } else if (state is SearchProductError) {
                  print(state.message);
                  return Center(child: Text("${state.message}"));
                } else {
                  return Center(child: Image.asset(Assets.imagesSearch));
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
