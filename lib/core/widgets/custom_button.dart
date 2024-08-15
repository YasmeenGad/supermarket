import 'package:flutter/material.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double? price;

  const CustomButton({super.key, required this.text, this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 67,
      decoration: BoxDecoration(
        color: const Color(0xff53B175),
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: AppStyles.styleSemiBold18(context)
                .copyWith(color: Colors.white),
          ),
          
        ],
      ),
    );
  }
}
