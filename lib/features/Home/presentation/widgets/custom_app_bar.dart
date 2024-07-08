import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                SizedBox(width: 16,),
                Icon(CupertinoIcons.shopping_cart,size: 30,),
              ],
            );
  }
}