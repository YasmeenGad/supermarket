import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/assets.dart';

class CustomContainerInternetConnection extends StatelessWidget {
  const CustomContainerInternetConnection({super.key, required this.state});
  final String state;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.imagesNoConnection),
            Text(
              "${state}",
              textAlign: TextAlign.center,
              style: TextStyle(color: darkColor, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
