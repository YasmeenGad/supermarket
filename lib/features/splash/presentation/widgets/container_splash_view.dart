import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/assets.dart';

class ContainerSplashView extends StatelessWidget {
  const ContainerSplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      color: primaryColor,
      child: SvgPicture.asset(
        Assets.imagesSplashScreen,
        fit: BoxFit.cover,
      ),
    );
  }
}
