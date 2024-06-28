import 'package:flutter/material.dart';
import 'package:supermarket/features/auth/presentation/views/login.dart';
import 'package:supermarket/features/auth/presentation/views/register.dart';
import 'package:supermarket/features/splash/presentation/views/onboarding_view.dart';
import 'package:supermarket/features/splash/presentation/views/splash_view.dart';


class AppRoutes {
  static const String splashView = '/';
  static const String onBoarding= 'onBoarding';
  static const String registerRoute = 'register';
  static const String loginRoute = 'login';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splashView: (context) => const SplashView(),
      onBoarding: (context) => const OnBoardingView(),
      registerRoute: (context) => const Register(),
      loginRoute: (context) => const Login(),
    };
  }
}
