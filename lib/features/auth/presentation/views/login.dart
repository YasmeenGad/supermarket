import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/models/custom_text_field_model.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/core/utils/validator.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_event.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_auth_text_section.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPassword = true;
  bool isEmailValid = false;

  void validateEmail(String value) {
    final email = value;
    if (Validators.validateEmail(email) == null) {
      setState(() {
        isEmailValid = true;
      });
    } else {
      setState(() {
        isEmailValid = false;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Image.asset(Assets.imagesSingin),
          _buildContainer(screenSize, context),
        ],
      ),
    );
  }

  Widget _buildContainer(Size screenSize, context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 223),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomAuthTextSection(
              title: 'Log in',
              subtitle: 'Enter your Email and Password',
            ),
          ),
          const SizedBox(height: 46),
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                  onChanged: validateEmail,
                  validator: (value) {
                    return Validators.validateEmail(value);
                  },
                  controller: emailController,
                  textFieldModel: CustomTextFieldModel(
                    text: 'Email',
                    hintText: 'email',
                    suffixIcon: isEmailValid
                        ? Icon(Icons.check, color: Colors.green)
                        : null,
                  ),
                ),
                CustomTextField(
                  isPassword: isPassword,
                  validator: (value) {
                    return Validators.validatePassword(value);
                  },
                  controller: passwordController,
                  textFieldModel: CustomTextFieldModel(
                    text: 'Password',
                    hintText: '****',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      icon: isPassword
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, AppRoutes.forgetPasswordRoute);
                      },
                        child: Text("Forget Password?",
                            style: AppStyles.styleMedium16(context)))),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('You have been logged in successfully'),
                  backgroundColor: Colors.green,
                ));
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.homeLayoutRoute,
                  (route) => false,
                );
              } else if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ));
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const CircularProgressIndicator(
                  color: primaryColor,
                );
              }
              return GestureDetector(
                onTap: () {
                  if (formKey.currentState?.validate() ?? false) {
                    final email = emailController.text;
                    final password = passwordController.text;

                    context.read<AuthBloc>().add(LoginEvent(email: email, password: password, ));
                  }
                },
                child: CustomButton(
                  text: 'Login',
                ),
              );
            },
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account?',
                style: AppStyles.styleSemiBold14(context)
                    .copyWith(color: darkColor),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.registerRoute);
                },
                child: Text(
                  'Sign Up',
                  style: AppStyles.styleSemiBold14(context)
                      .copyWith(color: primaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
