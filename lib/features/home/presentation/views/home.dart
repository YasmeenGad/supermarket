import 'package:flutter/material.dart';
import 'package:supermarket/core/utils/app_routes.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: InkWell(onTap:(){
          Navigator.pushNamed(context, AppRoutes.loginRoute);
        },child: Icon(Icons.logout)),
      ),
    );
  }
}