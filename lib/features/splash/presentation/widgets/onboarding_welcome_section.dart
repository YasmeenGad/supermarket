import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/widgets/custom_button.dart';

class OnboardingWelcomeSection extends StatelessWidget {
  const OnboardingWelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text(
            'Welcome\nto our store',
            style: AppStyles.styleSemiBold48
                .copyWith(color: Colors.white, letterSpacing: 0, height: 0),
          ),
        ),
        FittedBox(
          child: Text('Ger your groceries in as fast as one hour',
              style: AppStyles.styleMedium16.copyWith(color: whiteColor)),
        ),
        const SizedBox(
          height: 43,
        ),
        CustomButton(text: 'Get Started'),
      ],
    );
  }
}
