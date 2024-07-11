import 'package:flutter/material.dart';
import 'package:supermarket/features/Home/presentation/views/home_layout.dart';
import 'package:supermarket/features/auth/presentation/views/forget_password.dart';
import 'package:supermarket/features/auth/presentation/views/login.dart';
import 'package:supermarket/features/auth/presentation/views/register.dart';
import 'package:supermarket/features/auth/presentation/views/reset_password.dart';
import 'package:supermarket/features/auth/presentation/views/verify_otp.dart';
import 'package:supermarket/features/Product_details.dart/presentation/views/home.dart';
import 'package:supermarket/features/search/presentation/views/search_view.dart';
import 'package:supermarket/features/splash/presentation/views/onboarding_view.dart';
import 'package:supermarket/features/splash/presentation/views/splash_view.dart';

class AppRoutes {
  static const String splashView = '/';
  static const String onBoarding = 'onBoarding';
  static const String registerRoute = 'register';
  static const String loginRoute = 'login';
  static const String homeLayoutRoute = 'homeLayoutRoute';
  static const String forgetPasswordRoute = 'forgetPassword';
  static const String otpRoute = 'otp';
  static const String resetPasswordRoute = 'resetPassword';
  static const String searchViewRoute='searchViewRoute';
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splashView: (context) => const SplashView(),
      onBoarding: (context) => const OnBoardingView(),
      registerRoute: (context) => const Register(),
      loginRoute: (context) => const Login(),
      homeLayoutRoute: (context) => const HomeLayout(),
      forgetPasswordRoute: (context) => ForgetPassword(),
      otpRoute: (context) => VerifyOtp(),
      resetPasswordRoute: (context) => ResetPassword(
            token: ModalRoute.of(context)!.settings.arguments as String,
          ),
      searchViewRoute: (context) => const SearchView(),
    };
  }
}
