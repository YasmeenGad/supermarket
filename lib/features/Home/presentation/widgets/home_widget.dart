import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/Home/presentation/bloc/BestSellingProducts/best_selling_products_bloc.dart';
import 'package:supermarket/features/Home/presentation/bloc/all_product_bloc/all_products_bloc_bloc.dart';
import 'package:supermarket/features/Home/presentation/views/see_all_products.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_app_bar.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_carouser_slider.dart';
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
    // BlocProvider.of<AllProductsBlocBloc>(context).add(FetchProducts());
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
              const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const CustomAppBar(),
                    SizedBox(height: 8),
                    ImagePageView(
                      pageController: pageController,
                    ),
                    SizedBox(height: 16),
                    DotsIndicator(
                      currentPageIndex: currentPageIndex,
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Exclusive Offer",
                              style: AppStyles.styleSemiBold24(context)
                                  .copyWith(color: darkColor),
                            )),
                        Expanded(child: SizedBox()),
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                // Dispatch the event to fetch all products
                                final allProductsState =
                                    context.read<AllProductsBlocBloc>().state;
                                if (allProductsState is AllProductsBlocLoaded) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SeeAllProducts(
                                        products: allProductsState.products,
                                        title: 'Exclusive Offer',
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
                    ),
                    SizedBox(height: 16),
                    BlocListener<AllProductsBlocBloc,
                        AllProductsBlocState>(listener: (context, state) {
                      if (state is AllProductsBlocError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    }, child:
                        BlocBuilder<AllProductsBlocBloc, AllProductsBlocState>(
                      builder: (context, state) {
                        if (state is AllProductsBlocLoading) {
                          return Container(
                            width: MediaQuery.sizeOf(context).width * 0.2,
                            height: MediaQuery.sizeOf(context).height * 0.25,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            ),
                          );
                        } else if (state is AllProductsBlocLoaded) {
                          return ExclusiveOfferWidgetListView(
                            products: state.products,
                          );
                        }
                        return SizedBox();
                      },
                    )),
                    SizedBox(height: 16),
                    Row(
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
                    ),
                    SizedBox(height: 16),
                    BlocListener<BestSellingProductsBloc,
                        BestSellingProductsState>(listener: (context, state) {
                      if (state is BestSellingProductsError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    }, child: BlocBuilder<BestSellingProductsBloc,
                        BestSellingProductsState>(
                      builder: (context, state) {
                        if (state is BestSellingProductsLoading) {
                          return Container(
                            width: MediaQuery.sizeOf(context).width * 0.2,
                            height: MediaQuery.sizeOf(context).height * 0.25,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            ),
                          );
                        } else if (state is BestSellingProductsLoaded) {
                          return ExclusiveOfferWidgetListView(
                            products: state.products,
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
