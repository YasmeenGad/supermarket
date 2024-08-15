import 'package:flutter/material.dart';
import 'package:supermarket/features/checkout/presentation/widgets/payment_methods.dart';

class PaymentDetailsViewBody extends StatelessWidget {
  const PaymentDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PaymentMethodsListView(),
      ],
    );
  }
}
