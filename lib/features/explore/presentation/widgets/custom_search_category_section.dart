import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/search/presentation/bloc/search_category_bloc/search_category_bloc.dart';

class CustomSearchCategorySection extends StatefulWidget {
  const CustomSearchCategorySection({super.key});

  @override
  State<CustomSearchCategorySection> createState() =>
      _CustomSearchCategorySectionState();
}

class _CustomSearchCategorySectionState
    extends State<CustomSearchCategorySection> {
  final TextEditingController textController = TextEditingController();
  Timer? _debounceTimer; // Timer for debounce mechanism

  @override
  void initState() {
    super.initState();
    textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    textController.removeListener(_onTextChanged);
    textController.dispose();
    _debounceTimer?.cancel(); // Cancel the debounce timer if widget is disposed
    super.dispose();
  }

  void _onTextChanged() {
    if (_debounceTimer != null && _debounceTimer!.isActive) {
      _debounceTimer!.cancel(); // Cancel previous timer if active
    }

    _debounceTimer = Timer(Duration(milliseconds: 300), () {
      if (textController.text.isEmpty) {
        context.read<SearchCategoryBloc>().add(ClearSearchEvent());
      } else {
        context
            .read<SearchCategoryBloc>()
            .add(GetCategoryEvent(categoryName: textController.text.trim()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: Text('Find Products',
                style:
                    AppStyles.styleBold20(context).copyWith(color: darkColor)),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 51,
          decoration: BoxDecoration(
              color: bgTextFieldColor, borderRadius: BorderRadius.circular(16)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextField(
               onChanged: (value) {
                  _onTextChanged(); // Call the debounce function on text change
                },
                controller: textController,
                style:
                    AppStyles.styleMedium14(context).copyWith(color: darkColor),
                cursorColor: darkColor,
                decoration: InputDecoration(
                  prefixIcon: InkWell(
                      onTap: () {
                        context.read<SearchCategoryBloc>().add(
                            GetCategoryEvent(categoryName: textController.text.trim()));
                      },
                      child: Icon(
                        CupertinoIcons.search,
                        color: darkColor,
                      ),
                    ),
                  border: InputBorder.none,
                  hintText: 'Search store',
                )),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
