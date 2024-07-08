import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      children: [
        Flexible(
          child: AnimSearchBar(
            suffixIcon: Icon(Icons.search),
            width: 400,
            textController: textController,
            onSuffixTap: () {
              setState(() {
                textController.clear();
              });
            },
            onSubmitted: (String) {},
          ),
        ),
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
