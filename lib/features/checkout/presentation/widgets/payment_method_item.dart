import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/assets.dart';

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 103,
      height: 62,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: primaryColor, width: 1.50),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ]),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Center(
            child: SvgPicture.asset(
          Assets.imagesCard,
          height: 30.69,
          width: 45,
        )),
      ),
    );
  }
}
