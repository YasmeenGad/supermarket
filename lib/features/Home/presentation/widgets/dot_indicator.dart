import 'package:flutter/material.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_dot_indicator.dart';

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({super.key, required this.currentPageIndex});
  final int currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: CustomDotIndicator(isActive: index == currentPageIndex),
        ),
      ),
    );
  }
}