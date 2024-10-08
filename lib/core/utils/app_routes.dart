import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supermarket/features/Home/presentation/views/home_layout.dart';
import 'package:supermarket/features/Home/presentation/views/product_details_view.dart';
import 'package:supermarket/features/Home/presentation/views/see_all_products.dart';
import 'package:supermarket/features/auth/presentation/views/forget_password.dart';
import 'package:supermarket/features/auth/presentation/views/login.dart';
import 'package:supermarket/features/auth/presentation/views/register.dart';
import 'package:supermarket/features/auth/presentation/views/reset_password.dart';
import 'package:supermarket/features/auth/presentation/views/verify_otp.dart';
import 'package:supermarket/features/cart/presentation/views/cart_view.dart';
import 'package:supermarket/features/checkout/domain/entities/create_customer.dart';
import 'package:supermarket/features/checkout/presentation/views/payment_details.dart';
import 'package:supermarket/features/checkout/presentation/views/thank_you_view.dart';
import 'package:supermarket/features/favorite/presentation/views/fav_view.dart';
import 'package:supermarket/features/filter/presentation/views/filtered_products_view.dart';
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
  static const String searchViewRoute = 'searchViewRoute';
  static const String productDeatailsRoute = 'productDetailsRoute';
  static const String filteredProductsViewRoute = 'filteredProductsViewRoute';
  static const String seeAllProductsRoute = 'seeAllProductsRoute';
  static const String cartRoute = 'cartRoute';
  static const String favRoute = 'favRoute';
  static const String paymentDetailsRoute = 'paymentDetailsRoute';
  static const String paymentSuccessRoute = 'paymentSuccessRoute';
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splashView: (context) => const SplashView(),
      onBoarding: (context) => const OnBoardingView(),
      registerRoute: (context) => const Register(),
      loginRoute: (context) => Login(
            customer: ModalRoute.of(context)?.settings.arguments as Customer?,
          ),
      homeLayoutRoute: (context) => HomeLayout(
            customer: ModalRoute.of(context)?.settings.arguments as Customer?,
          ),
      forgetPasswordRoute: (context) => ForgetPassword(customer: ModalRoute.of(context)?.settings.arguments as Customer),
      otpRoute: (context) => VerifyOtp(customer: ModalRoute.of(context)?.settings.arguments as Customer),
      resetPasswordRoute: (context) => ResetPassword(
            token: ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>,
            customer: ModalRoute.of(context)?.settings.arguments as Map<String,dynamic>,
          ),
      searchViewRoute: (context) => const SearchView(),
      productDeatailsRoute: (context) => ProductDetailsView(
          products: ModalRoute.of(context)!.settings.arguments),
      filteredProductsViewRoute: (context) => FilteredProductsView(
          categoryName: ModalRoute.of(context)!.settings.arguments as String),
      seeAllProductsRoute: (context) => SeeAllProducts(
            title: ModalRoute.of(context)!.settings.arguments as String,
            products: ModalRoute.of(context)!.settings.arguments as List,
          ),
      cartRoute: (context) => CartView(
            customer: ModalRoute.of(context)!.settings.arguments as Customer,
          ),
      favRoute: (context) => FavView(),
      paymentDetailsRoute: (context) => const PaymentDetailsView(),
      paymentSuccessRoute: (context) =>  ThankYouView(
          customer: ModalRoute.of(context)?.settings.arguments as Customer)
    };
  }
}
