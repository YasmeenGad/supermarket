import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem(
      {super.key, this.isActive = true, required this.image});

  final bool isActive;
  final String image;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 103,
      height: 62,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: isActive ? Color(0xff34A853) : Color(0xff000000),
              width: 1.50),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: isActive ? Color(0xff34A853) : Colors.white,
              blurRadius: 5,
              offset: Offset(0, 0),
            ),
          ]),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: SvgPicture.asset(
            image,
            fit: BoxFit.scaleDown,
            height: 30.69,
            width: 45,
          )),
        ),
      ),
    );
  }
}
