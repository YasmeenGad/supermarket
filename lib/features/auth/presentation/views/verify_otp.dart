import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/widgets/custom_awesome_dialog.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/core/widgets/custom_loading_indicator.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_event.dart';
import 'package:supermarket/features/checkout/domain/entities/create_customer.dart';

class VerifyOtp extends StatefulWidget {
  VerifyOtp({Key? key, required this.customer}) : super(key: key);
  Customer customer;

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  String otpCode = '';

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
                    'OTP Verification',
                    style: AppStyles.styleSemiBold24(context)
                        .copyWith(color: darkColor),
                  ),
                ),
                SizedBox(height: 20),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter the OTP sent to your email',
                    style: AppStyles.styleSemiBold16(context)
                        .copyWith(color: secondaryColor),
                  ),
                ),
                SizedBox(height: 40),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: OtpTextField(
                    numberOfFields: 6,
                    borderColor: primaryColor,
                    showFieldAsBox: true,
                    fieldWidth: 60,
                    autoFocus: true,
                    onSubmit: (String otp) {
                      otpCode = otp;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(height: 20),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccessResetPassword) {
                      Navigator.pushNamed(context, AppRoutes.resetPasswordRoute,
                          arguments: {
                            'token': state.token,
                            'customer': widget.customer,
                          });
                    } else if (state is AuthFailureResetPassword) {
                      CustomAwesomDialog.showErrorDialog(context, state.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoadingResetPassword) {
                      return CustomLoadingIndicator();
                    }
                    return GestureDetector(
                      onTap: () {
                        if (otpCode.isNotEmpty) {
                          BlocProvider.of<AuthBloc>(context)
                              .add(VerifyOtpEvent(otp: otpCode));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please enter OTP')),
                          );
                        }
                      },
                      child: CustomButton(text: 'Verify OTP'),
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
