import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';

class CustomSearch extends StatefulWidget {
  const CustomSearch({super.key});

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    return  Flexible(
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
        );
  }
}