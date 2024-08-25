import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/features/Home/presentation/bloc/BestSellingProducts/best_selling_products_bloc.dart';
import 'package:supermarket/features/Home/presentation/bloc/all_product_bloc/all_products_bloc_bloc.dart';
import 'package:supermarket/features/Home/presentation/bloc/update_quantity/update_quantity_bloc.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:supermarket/features/cart/presentation/bloc/delete_item_bloc/delete_item_bloc.dart';
import 'package:supermarket/features/cart/presentation/bloc/get_total_order.dart/get_total_order_bloc.dart';
import 'package:supermarket/features/cart/presentation/bloc/create_order_bloc/create_order_bloc.dart';
import 'package:supermarket/features/cart/presentation/bloc/get_order_bloc/get_order_bloc.dart';
import 'package:supermarket/features/checkout/presentation/bloc/payment_bloc/payment_bloc.dart';
import 'package:supermarket/features/explore/presentation/bloc/categoruBloc/category_bloc.dart';
import 'package:supermarket/features/favorite/presentation/bloc/add_fav_products/add_favorite_product_bloc.dart';
import 'package:supermarket/features/favorite/presentation/bloc/delete_all_fav/delete_all_favorite_products_bloc.dart';
import 'package:supermarket/features/favorite/presentation/bloc/delete_one_fav_products/delete_one_favorite_product_bloc.dart';
import 'package:supermarket/features/favorite/presentation/bloc/get_fav_products/get_favorite_products_bloc.dart';

import 'package:supermarket/features/filter/presentation/bloc/filtered_products_bloc/filtered_products_bloc.dart';
import 'package:supermarket/features/explore/presentation/bloc/search_category_bloc/search_category_bloc.dart';
import 'package:supermarket/features/search/presentation/bloc/search_product_bloc/search_product_bloc.dart';
import 'package:supermarket/injection_container.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const SuperMarket(),
    ),
  );
}

class SuperMarket extends StatelessWidget {
  const SuperMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<AuthBloc>()),
          BlocProvider(create: (context) => sl<AllProductsBlocBloc>()),
          BlocProvider(
            create: (context) => sl<BestSellingProductsBloc>(),
          ),
          BlocProvider(create: (context) => sl<SearchProductBloc>()),
          BlocProvider(create: (context) => sl<CategoryBloc>()),
          BlocProvider(create: (context) => sl<SearchCategoryBloc>()),
          BlocProvider(create: (context) => sl<FilteredProductsBloc>()),
          BlocProvider(create: (context) => sl<CreateOrderBloc>()),
          BlocProvider(create: (context) => sl<GetOrderBloc>()),
          BlocProvider(create: (context) => sl<GetTotalOrderBloc>()),
          BlocProvider(create: (context) => sl<AddFavoriteProductBloc>()),
          BlocProvider(create: (context) => sl<GetFavoriteProductsBloc>()),
          BlocProvider(create: (context) => sl<DeleteOneFavoriteProductBloc>()),
          BlocProvider(
              create: (context) => sl<DeleteAllFavoriteProductsBloc>()),
          BlocProvider(create: (context) => sl<DeleteItemBloc>()),
          BlocProvider(create: (context) => sl<UpdateQuantityBloc>()),
          BlocProvider(create: (context) => sl<PaymentBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splashView,
          routes: AppRoutes.getRoutes(),
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
        ));
  }
}

// create payment sheet that take current & amount
// init payment sheet 
// present payment sheet

