import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:supermarket/features/search/presentation/widgets/custom_search.dart';

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
      children: [
       CustomSearch(),
        SizedBox(
          width: 16,
        ),
        badges.Badge(
          showBadge: true,
           position: badges.BadgePosition.topEnd(top: -5, end: 2),
          badgeContent: Text(''),
          child: IconButton(
            onPressed: () {},
           icon: Icon( CupertinoIcons.shopping_cart,
            size: 30,)
          ),
        ),
      ],
    );
  }
}
