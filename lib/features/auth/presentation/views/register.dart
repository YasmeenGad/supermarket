import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/models/custom_text_field_model.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/core/validators/validator.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/core/widgets/custom_loading_indicator.dart';
import 'package:supermarket/core/widgets/custome_snackbar.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_event.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_auth_text_section.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_text_auth.dart';
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
    usernameController.dispose();
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
              title: 'Sign Up',
              subtitle: 'Enter your credentials to continue',
            ),
          ),
          const SizedBox(height: 46),
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                  validator: (value) {
                    return Validators.validateUsername(value);
                  },
                  controller: usernameController,
                  textFieldModel: CustomTextFieldModel(
                    text: 'Username',
                    hintText: 'username',
                    suffixIcon: Icon(
                      Icons.person_outline,
                      color: primaryColor,
                    ),
                  ),
                ),
                CustomTextField(
                  onChanged: validateEmail,
                  validator: (value) {
                    return Validators.validateEmail(value);
                  },
                  controller: emailController,
                  textFieldModel: CustomTextFieldModel(
                    text: 'Email',
                    hintText: 'email',
                    suffixIcon: Icon(Icons.email_outlined,
                        color: isEmailValid ? primaryColor : Colors.grey),
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
                    hintText: '******',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      icon: isPassword
                          ? Icon(
                              Icons.visibility,
                              color: primaryColor,
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: primaryColor,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is CustomerLoaded) {
                print("loaded");
                Navigator.pushReplacementNamed(context, AppRoutes.loginRoute,
                    arguments: state.customer);
              } else if (state is AuthFailure || state is CustomerError) {
                print("failure");
                String errorMessage;
                if (state is AuthFailure) {
                  errorMessage = state.error;
                } else if (state is CustomerError) {
                  errorMessage = state.message;
                } else {
                  errorMessage = 'An unexpected error occurred';
                }

                CustomeSnackbar.showErrorSnackbar(context, errorMessage);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading || state is CustomerLoading) {
                print("loading");
                return const CustomLoadingIndicator();
              }
              return GestureDetector(
                onTap: () {
                  if (formKey.currentState?.validate() ?? false) {
                    final userName = usernameController.text.trim();
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    context.read<AuthBloc>().add(RegisterEvent(
                        userName: userName, email: email, password: password));
                    context
                        .read<AuthBloc>()
                        .add(CreateCustomerEvent(name: userName));
                  }
                },
                child: CustomButton(
                  text: 'Sign Up',
                ),
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),

          CustomTextAuth(
              text: 'Already have an account?',
              textAuth: 'Login',
              route: AppRoutes.loginRoute),
          // SizedBox(height: 16,),
        ],
      ),
    );
  }
}







