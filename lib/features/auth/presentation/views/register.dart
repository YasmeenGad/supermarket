import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/models/custom_text_field_model.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/core/utils/validator.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_auth_text_section.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_text_field.dart';
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
              alignment: Alignment.centerLeft, child: CustomAuthTextSection(title: 'Sign Up', subtitle: 'Enter your credentials to continue',)),
          const SizedBox(height: 46),
          CustomTextField(
            validator: (value){
            return   Validators.validateUsername(value);
            },
            formKey: formKey,
            controller: usernameController,
            textFieldModel:
                CustomTextFieldModel(text: 'Username', hintText: 'username'),
          ),
          CustomTextField(
            validator: (value){
            return   Validators.validateEmail(value);
            },
            formKey: formKey,
            controller: emailController,
            textFieldModel: CustomTextFieldModel(
                text: 'Email',
                hintText: 'email',
                suffixIcon: Image.asset(Assets.imagesVector)),
          ),
           CustomTextField(
            validator: (value){
            return   Validators.validatePassword(value);
            },
            formKey: formKey,
            controller: passwordController,
            textFieldModel: CustomTextFieldModel(
                text: 'Password',
                hintText: 'password',
                suffixIcon: Icon(Icons.visibility_off)),
          ),
          const CustomButton(text: 'Sign Up'),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: AppStyles.styleSemiBold14(context).copyWith(color: darkColor),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
                },
                child: Text(
                  'Login',
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
