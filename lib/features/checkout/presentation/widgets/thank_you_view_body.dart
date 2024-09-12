import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg package
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/features/checkout/domain/entities/create_customer.dart';

class ThankYouViewBody extends StatelessWidget {
  const ThankYouViewBody({super.key, required this.customer});
  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  Assets.imageSuccess,
                  width: 269,
                  height: 240,
                ),
                const SizedBox(height: 32),
                Text(
                  'Your Order has been accepted',
                  style: AppStyles.styleSemiBold28(context)
                      .copyWith(color: darkColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Text(
                  'Your items have been placed and are on their way to being processed',
                  style: AppStyles.styleMedium16(context)
                      .copyWith(color: secondaryColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeLayoutRoute,(route) => false, arguments: customer);
              },
              child: CustomButton(text: "Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
