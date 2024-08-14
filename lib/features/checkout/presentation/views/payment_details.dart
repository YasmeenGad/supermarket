import 'package:flutter/material.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_text_bar.dart';
import 'package:supermarket/features/checkout/presentation/widgets/payment_details_view_body.dart';

class PaymentDetailsView extends StatelessWidget {
  const PaymentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomTextBar(
          text: "Payment Details",
        ),
        body: const PaymentDetailsViewBody(),
        
        );
  }
}
