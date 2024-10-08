import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/models/custom_text_field_model.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/validators/validator.dart';
import 'package:supermarket/core/widgets/custom_awesome_dialog.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/core/widgets/custom_loading_indicator.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_event.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:supermarket/features/checkout/domain/entities/create_customer.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key, required this.customer}) : super(key: key);
  Customer customer;

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.customer = ModalRoute.of(context)!.settings.arguments as Customer;

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
                    'Forget Password',
                    style: AppStyles.styleSemiBold24(context)
                        .copyWith(color: darkColor),
                  ),
                ),
                SizedBox(height: 20),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please enter your email to get OTP',
                    style: AppStyles.styleSemiBold16(context)
                        .copyWith(color: secondaryColor),
                  ),
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: CustomTextField(
                    validator: (value) {
                      return Validators.validateEmail(value);
                    },
                    textFieldModel:
                        CustomTextFieldModel(text: 'Your Email', hintText: ''),
                    controller: _emailController,
                  ),
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccessResetPassword) {
                      Navigator.pushNamed(context, AppRoutes.otpRoute, arguments: widget.customer);
                    } else if (state is AuthFailureResetPassword) {
                      CustomAwesomDialog.showErrorDialog(context, state.error);
                    }
                  },
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoadingResetPassword) {
                        return CustomLoadingIndicator();
                      }

                      return GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            BlocProvider.of<AuthBloc>(context).add(
                                SendResetCodeEvent(
                                    email: _emailController.text));
                          }
                        },
                        child: CustomButton(text: 'Send Code'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
