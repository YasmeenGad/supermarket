import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/widgets/custom_button.dart';

class OnboardingWelcomeSection extends StatelessWidget {
  const OnboardingWelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildWelcomeText(),
        _buildSubtitleText(),
        const SizedBox(height: 43),
        _buildGetStartedButton(context),
      ],
    );
  }

  Widget _buildWelcomeText() {
    return FittedBox(
      child: Text(
        'Welcome to our store',
        style: AppStyles.styleSemiBold48.copyWith(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSubtitleText() {
    return FittedBox(
      child: Text(
        'Get your groceries in as fast as one hour',
        style: AppStyles.styleMedium16.copyWith(color: whiteColor),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.registerRoute),
      child: CustomButton(
        text: 'Get Started',
      ),
    );
  }
}
