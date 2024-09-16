import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/features/Home/presentation/views/home_layout.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/checkout/data/datasource/payment_local_datasource.dart';
import 'package:supermarket/features/checkout/domain/entities/create_customer.dart';
import 'package:supermarket/features/splash/presentation/views/onboarding_view.dart';
import 'package:supermarket/features/splash/presentation/widgets/container_splash_view.dart';
import 'package:supermarket/core/config/injection_container.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _checkLoginAndGetCustomer(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('An error occurred: ${snapshot.error}'));
        }

        final result = snapshot.data;
        if (result == null) {
          return const Center(child: Text('Unexpected error occurred'));
        }

        final isLoggedIn = result['isLoggedIn'] as bool;
        final customer = result['customer'] as Customer?;

        return AnimatedSplashScreen(
          splashIconSize: MediaQuery.of(context).size.height,
          splash: const ContainerSplashView(),
          nextScreen: isLoggedIn
              ? HomeLayout(
                  customer: customer!) // Use a default customer if null
              : OnBoardingView(),
          splashTransition: SplashTransition.scaleTransition,
          duration: 3000,
        );
      },
    );
  }

  Future<Map<String, dynamic>> _checkLoginAndGetCustomer() async {
    try {
      final authLocalDataSource = sl<AuthLocalDataSource>();
      final paymentLocalDatasource = sl<PaymentLocalDatasource>();

      final loginResponse = await authLocalDataSource.getCachedLoginResponse();
      final customer = await paymentLocalDatasource.getCachedCustomer();
      print(customer!.id);
      return {
        'isLoggedIn': loginResponse?.token != null,
        'customer': customer,
      };
    } catch (e) {
      print('Error fetching login status or customer: $e');
      return {
        'isLoggedIn': false,
        'customer': null,
      };
    }
  }
}
