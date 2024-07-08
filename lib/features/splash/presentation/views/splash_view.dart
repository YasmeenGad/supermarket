import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/features/Home/presentation/views/home_layout.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/splash/presentation/views/onboarding_view.dart';
import 'package:supermarket/features/splash/presentation/widgets/container_splash_view.dart';
import 'package:supermarket/injection_container.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: isUserLoggedIn(), builder: (context, snapshot) {
      return AnimatedSplashScreen(
      splashIconSize: MediaQuery.of(context).size.height,
      splash: const ContainerSplashView(),
      nextScreen: snapshot.data??false ? HomeLayout(): OnBoardingView(),
      splashTransition: SplashTransition.scaleTransition,
      duration: 3000,
    );
    },);
  }

    Future<bool> isUserLoggedIn() async {
    final authLocalDataSource = sl<AuthLocalDataSource>();
    final token = await authLocalDataSource.getCachedToken();
    return token != null && token.isNotEmpty;
  }
}
