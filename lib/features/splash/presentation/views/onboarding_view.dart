import 'package:flutter/material.dart';
import 'package:supermarket/features/splash/presentation/widgets/background_onboarding_container_section.dart';
import 'package:supermarket/features/splash/presentation/widgets/onboarding_welcome_section.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundOnBoardingContainerSection(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox()),
                Expanded(
                  child: OnboardingWelcomeSection()
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

