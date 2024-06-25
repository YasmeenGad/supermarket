import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_auth_text_section.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_text_field_section.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Image.asset(Assets.imagesSingin),
          _buildContainer(screenSize),
        ],
      ),
    );
  }

  Widget _buildContainer(Size screenSize) {
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 223),
          Align(
              alignment: Alignment.centerLeft, child: CustomAuthTextSection()),
          const SizedBox(height: 46),
          CustomTextFieldSection(),
          const CustomButton(text: 'Sign Up'),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: AppStyles.styleSemiBold14.copyWith(color: darkColor),
              ),
              Text(
                'Login',
                style: AppStyles.styleSemiBold14.copyWith(color: primaryColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
