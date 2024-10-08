import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:badges/badges.dart' as badges;

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.searchViewRoute);
            },
            icon: Icon(
              CupertinoIcons.search,
              size: 30,
              color: darkColor,
            )),

        badges.Badge(
          showBadge: true,
          position: badges.BadgePosition.topEnd(top: -5, end: 2),
          badgeContent: Text(''),
          child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.cartRoute);
              },
              icon: Icon(
                CupertinoIcons.shopping_cart,
                size: 30,
                color: darkColor,
              )),
        ),
      ],
    );
  }
}
