import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/explore/presentation/bloc/search_category_bloc/search_category_bloc.dart';

class CustomCategorySearchField extends StatefulWidget {
  const CustomCategorySearchField({super.key});

  @override
  State<CustomCategorySearchField> createState() =>
      _CustomCategorySearchFieldState();
}

class _CustomCategorySearchFieldState extends State<CustomCategorySearchField> {
  final TextEditingController textController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    textController.removeListener(_onTextChanged);
    textController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onTextChanged() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      final query = textController.text.trim();
      if (query.isEmpty) {
        context.read<SearchCategoryBloc>().add(ClearSearchEvent());
      } else {
        context
            .read<SearchCategoryBloc>()
            .add(GetCategoryEvent(categoryName: query));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 51,
      decoration: BoxDecoration(
        color: bgTextFieldColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextField(
          controller: textController,
          style: AppStyles.styleMedium14(context).copyWith(color: darkColor),
          cursorColor: darkColor,
          decoration: InputDecoration(
            prefixIcon: InkWell(
              onTap: () {
                context.read<SearchCategoryBloc>().add(
                    GetCategoryEvent(categoryName: textController.text.trim()));
              },
              child: Icon(CupertinoIcons.search, color: darkColor),
            ),
            border: InputBorder.none,
            hintText: 'Search store',
            hintStyle:
                AppStyles.styleMedium16(context).copyWith(color: darkColor),
            contentPadding: const EdgeInsets.only(
                left: 48, top: 14), 
          ),
        ),
      ),
    );
  }
}
