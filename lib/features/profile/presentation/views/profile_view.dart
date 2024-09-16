import 'package:flutter/material.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/profile/presentation/widgets/profile_menu.dart';
import 'package:supermarket/features/profile/presentation/widgets/profile_pic.dart';
import 'package:supermarket/core/config/injection_container.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 16),
            Text(
              "Yasmeen Gad",
              style: AppStyles.styleBold20(context),
            ),
            const SizedBox(height: 16),
            ProfileMenu(
              text: "My Account",
              icon: Icons.person,
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: Icons.settings,
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: Icons.logout,
              press: () async {
                final authLocalDataSource = await sl.get<AuthLocalDataSource>();
                await authLocalDataSource.logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.loginRoute,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
