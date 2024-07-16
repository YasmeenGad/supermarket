import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomQuantity extends StatelessWidget {
  const CustomQuantity({super.key, this.price, required this.quantity});
  final price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
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
        ),
        Expanded(child: SizedBox()),
        Text(
          "\$${price}",
          style: AppStyles.styleBold24(context).copyWith(color: blackColor),
        ),
      ],
    );
  }
}
