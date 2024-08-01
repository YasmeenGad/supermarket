import 'package:flutter/material.dart';

class CartContainer extends StatelessWidget {
  const CartContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [child],
      ),
    );
  }
}
