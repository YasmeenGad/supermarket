import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/models/custom_text_field_model.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/utils/validator.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_event.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:supermarket/injection_container.dart';

class ResetPassword extends StatefulWidget {
   String token;

  ResetPassword({Key? key, required this.token}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPassword = true;
  final authLocalDataSource= sl<AuthLocalDataSource>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize token from arguments 
    if (widget.token.isEmpty) {
      widget.token = ModalRoute.of(context)!.settings.arguments as String;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios_new, color: darkColor),
                ),
                SizedBox(height: 20),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Reset your password',
                    style: AppStyles.styleSemiBold24(context)
                        .copyWith(color: darkColor),
                  ),
                ),
                SizedBox(height: 20),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter new password',
                    style: AppStyles.styleSemiBold16(context)
                        .copyWith(color: secondaryColor),
                  ),
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: CustomTextField(
                    isPassword: isPassword,
                    validator: (value) {
                      return Validators.validatePassword(value);
                    },
                    controller: _passwordController,
                    textFieldModel: CustomTextFieldModel(
                      text: 'New Password',
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
                ),
                SizedBox(height: 20),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccessResetPassword) {

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Password reset successfully')));
                          authLocalDataSource.removeCachedToken();
                      Navigator.pushNamed(context, AppRoutes.loginRoute);
                    } else if (state is AuthFailureResetPassword) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoadingResetPassword) {
                      return Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                            ResetPasswordEvent(
                              token: widget.token,
                              newPassword: _passwordController.text,
                            ),
                          );
                        }
                      },
                      child: CustomButton(text: 'Reset Password'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
