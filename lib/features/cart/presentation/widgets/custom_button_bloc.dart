import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/utils/app_routes.dart';
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
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.paymentSuccessRoute, (Route<dynamic> route) => false);
        }
        if (state is PaymentError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error, color: Colors.white),
                  const SizedBox(width: 8.0),
                  Expanded(child: Text(state.message)),
                ],
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(16.0),
              action: SnackBarAction(
                label: 'OK',
                textColor: Colors.white,
                onPressed: () {},
              ),
            ),
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
