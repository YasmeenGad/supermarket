import 'package:flutter/material.dart';
import 'package:supermarket/features/checkout/presentation/widgets/payment_method_item.dart';

class PaymentDetailsViewBody extends StatelessWidget {
  const PaymentDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaymentMethodItem(),
      ],
    );
  }
}
