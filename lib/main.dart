import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/utils/app_routes.dart';

import 'package:supermarket/features/Home/presentation/bloc/BestSellingProducts/best_selling_products_bloc.dart';
import 'package:supermarket/features/Home/presentation/bloc/all_product_bloc/all_products_bloc_bloc.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:supermarket/injection_container.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const SuperMarket());
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
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splashView,
          routes: AppRoutes.getRoutes(),
        ));
  }
}
