import 'package:flutter/material.dart';
import 'package:supermarket/core/utils/assets.dart';

class BackgroundOnBoardingContainerSection extends StatelessWidget {
  const BackgroundOnBoardingContainerSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        Assets.images81401,
        fit: BoxFit.cover,
      ),
    );
  }
}
