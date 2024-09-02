import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:supermarket/features/checkout/domain/entities/create_customer.dart';
import 'package:supermarket/features/checkout/presentation/bloc/payment_bloc/payment_bloc.dart';

class CustomButtonBloc extends StatelessWidget {
  final dynamic amount;
  final Customer? customer;
  const CustomButtonBloc(
      {super.key, required this.amount, required this.customer});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset(
                              Assets.imageSuccess,
                              // width: 269,
                              // height: 240,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Your Order has been accepted',
                              style: AppStyles.styleSemiBold28(context)
                                  .copyWith(color: darkColor),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Your items have been placed and are on their way to being processed',
                              style: AppStyles.styleMedium16(context)
                                  .copyWith(color: secondaryColor),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(); // Close the dialog
                            // Navigator.pushNamedAndRemoveUntil(
                            //   context,
                            //   AppRoutes.homeLayoutRoute,
                            //   (Route<dynamic> route) => false,
                            // ); // Navigate to the home screen
                          },
                          child: CustomButton(text: "Okay"),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
      builder: (context, state) {
        return Container(
          width: MediaQuery.sizeOf(context).width,
          child: Center(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.5,
              child: GestureDetector(
                onTap: () {
                  context.read<PaymentBloc>().add(
                        MakePaymentEvent(
                          paymentIntentInputModel: PaymentIntentInputModel(
                            amount: amount,
                            currency: 'USD',
                            customerId: '${customer?.id}',
                          ),
                        ),
                      );
                },
                child: CustomButton(
                  isLoading: state is PaymentLoading,
                  text: "Continue",
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
