import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/models/custom_text_field_model.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_auth_text_section.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_text_field.dart';
class Login extends StatelessWidget {
  const Login({super.key});

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
          _buildContainer(screenSize,context),
        ],
      ),
    );
  }

  Widget _buildContainer(Size screenSize,context) {
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
              alignment: Alignment.centerLeft, child: CustomAuthTextSection(title: 'Logining', subtitle: 'Enter your email and password')),
          const SizedBox(height: 46),
          CustomTextField(textFieldModel: CustomTextFieldModel(text: 'Email', hintText: 'email')),
          CustomTextField(textFieldModel: CustomTextFieldModel(text: 'Password', hintText: 'password')),
          const CustomButton(text: 'Login'),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account? ',
                style: AppStyles.styleSemiBold14(context).copyWith(color: darkColor),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.registerRoute);
                },
                child: Text(
                  'SignUp',
                  style: AppStyles.styleSemiBold14(context).copyWith(color: primaryColor),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
