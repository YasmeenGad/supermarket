import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/search/presentation/bloc/search_product_bloc/search_product_bloc.dart';

class CustomSearchField extends StatefulWidget {
  const CustomSearchField({super.key});

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
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
        context.read<SearchProductBloc>().add(ClearSearchEvent());
      } else {
        context.read<SearchProductBloc>().add(SearchProduct(query: textController.text.trim()));
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
      child: TextField(
        onChanged: (value) {
          _onTextChanged(); // Call the debounce function on text change
        },
        controller: textController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search Store',
          hintStyle: AppStyles.styleSemiBold16(context).copyWith(color: secondaryColor),
          prefixIcon: InkWell(
            onTap: () {
              context.read<SearchProductBloc>().add(SearchProduct(query: textController.text.trim()));
            },
            child: Icon(
              CupertinoIcons.search,
              color: darkColor,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Padding for content
        ),
        textAlign: TextAlign.left, 
      ),
    );
  }
}
