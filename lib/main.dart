import 'package:flutter/material.dart';
import 'package:supermarket/core/utils/app_routes.dart';

void main(List<String> args) {
  runApp(const SuperMarket());
}

class SuperMarket extends StatelessWidget {
  const SuperMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashView,
      routes: AppRoutes.getRoutes(),
    );
  }
}
