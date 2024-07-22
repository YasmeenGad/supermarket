import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/core/widgets/custom_awesom_dialog.dart';
import 'package:supermarket/core/widgets/custom_loading_indicator.dart';
import 'package:supermarket/features/Home/presentation/bloc/BestSellingProducts/best_selling_products_bloc.dart';
import 'package:supermarket/features/Home/presentation/bloc/all_product_bloc/all_products_bloc_bloc.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_app_bar.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_best_seller_widget.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_best_selling_list_view.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_carouser_slider.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_header_best_selling.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_header_exclusive_header.dart';
import 'package:supermarket/features/Home/presentation/widgets/dot_indicator.dart';
import 'package:supermarket/features/Home/presentation/widgets/exclusive_offer_widget_list_view.dart';
import 'package:supermarket/injection_container.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final pageController = sl<PageController>();
  int currentPageIndex = 0;
  final internetConnect = sl<NetworkInfo>();

  @override
  void initState() {
    pageController.addListener(
      () {
        currentPageIndex = pageController.page!.round();
        setState(() {});
      },
    );
    // Dispatch the event to fetch all products
    context.read<AllProductsBlocBloc>().add(FetchProducts());

    // Dispatch the event to fetch best-selling products
    context.read<BestSellingProductsBloc>().add(GetBestSellingProducts());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      color: Colors.white,
      child: Padding(
          padding:
              const EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const CustomAppBar(),
                    SizedBox(height: 12),
                    ImagePageView(
                      pageController: pageController,
                    ),
                    SizedBox(height: 16),
                    DotsIndicator(
                      currentPageIndex: currentPageIndex,
                    ),
                    SizedBox(height: 24),
                    CustomHeaderExclusiveHeader(),
                    SizedBox(height: 16),
                    BlocListener<AllProductsBlocBloc,
                        AllProductsBlocState>(listener: (context, state) {
                      if (state is AllProductsBlocError) {
                       CustomAwesomDialog.showErrorDialog(context, state.message);
                      }
                    }, child:
                        BlocBuilder<AllProductsBlocBloc, AllProductsBlocState>(
                      builder: (context, state) {
                        if (state is AllProductsBlocLoading) {
                          return CustomLoadingIndicator();
                        } else if (state is AllProductsBlocLoaded) {
                          return ExclusiveOfferWidgetListView(
                            products: state.products,
                          );
                        }
                        return SizedBox();
                      },
                    )),
                    SizedBox(height: 16),
                    CustomHeaderBestSelling(),
                    SizedBox(height: 16),
                    BlocListener<BestSellingProductsBloc,
                        BestSellingProductsState>(listener: (context, state) {
                      if (state is BestSellingProductsError) {
                        CustomAwesomDialog.showErrorDialog(context, state.message);
                      }
                    }, child: BlocBuilder<BestSellingProductsBloc,
                        BestSellingProductsState>(
                      builder: (context, state) {
                        if (state is BestSellingProductsLoading) {
                          return CustomLoadingIndicator();
                        } else if (state is BestSellingProductsLoaded) {
                          return CustomBestSellingListView(
                            product: state.products,
                          );
                        }
                        return SizedBox();
                      },
                    )),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
