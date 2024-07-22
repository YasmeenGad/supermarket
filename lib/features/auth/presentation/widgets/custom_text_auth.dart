import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomTextAuth extends StatelessWidget {
  const CustomTextAuth({super.key, required this.text, required this.textAuth, this.route});
  final String text;
  final String textAuth;
  final dynamic route;
  

  @override
  Widget build(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${text}',
                style: AppStyles.styleSemiBold14(context)
                    .copyWith(color: darkColor),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, route );
                },
                child: Text(
                  '${textAuth}',
                  style: AppStyles.styleSemiBold14(context)
                      .copyWith(color: primaryColor),
                ),
              ),
            ],
          );
  }
}