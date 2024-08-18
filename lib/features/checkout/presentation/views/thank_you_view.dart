import 'package:flutter/material.dart';
import 'package:supermarket/features/checkout/presentation/widgets/thank_you_view_body.dart';

class ThankYouView extends StatelessWidget {
  const ThankYouView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ThankYouViewBody(),
    );
  }
}