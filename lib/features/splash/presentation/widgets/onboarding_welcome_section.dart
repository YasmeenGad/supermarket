import 'package:flutter/material.dart';
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
        _buildWelcomeText(context),
        _buildSubtitleText(context),
        const SizedBox(height: 43),
        _buildGetStartedButton(context),
      ],
    );
  }

  Widget _buildWelcomeText(context) {
    return FittedBox(
      child: Text(
        'Welcome to our store',
        style: AppStyles.styleSemiBold48(context).copyWith(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSubtitleText(context) {
    return FittedBox(
      child: Text(
        'Get your groceries in as fast as one hour',
        style: AppStyles.styleMedium16(context).copyWith(color: whiteColor),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.loginRoute),
      child: CustomButton(
        text: 'Get Started',
      ),
    );
  }
}
