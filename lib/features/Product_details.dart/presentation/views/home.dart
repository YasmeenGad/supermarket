import 'package:flutter/material.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/injection_container.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCashedUserName(),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Hello ${snapshot.data}"),
            leading: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.loginRoute);
                },
                child: Icon(Icons.logout)),
          ),
        );
      },
    );
  }

  Future<String> getCashedUserName() async {
    final authocalDataSource = sl<AuthLocalDataSource>();
    final userName = await authocalDataSource.getCachedUser();
    return userName!.userName;
  }
}
