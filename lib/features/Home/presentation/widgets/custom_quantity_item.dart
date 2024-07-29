import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';

class CustomQuantityItem extends StatelessWidget {
  final int quantity;
  const CustomQuantityItem({super.key, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.remove,
              color: Color(0xffB3B3B3),
            )),
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: borderColor)),
          child: Center(
            child: Text('${quantity}'),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
              color: primaryColor,
            )),
      ],
    );
  }
}
