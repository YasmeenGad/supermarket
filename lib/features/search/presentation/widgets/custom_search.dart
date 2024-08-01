import 'package:flutter/material.dart';
import 'package:supermarket/features/search/presentation/widgets/custom_header.dart';
import 'package:supermarket/features/search/presentation/widgets/custom_result_header.dart';
import 'package:supermarket/features/search/presentation/widgets/custom_search_field.dart';
import 'package:supermarket/features/search/presentation/widgets/custom_search_result.dart';

class CustomSearch extends StatefulWidget {
  const CustomSearch({Key? key}) : super(key: key);

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomHeader(),
            const SizedBox(height: 16),
            const CustomSearchField(),
            const SizedBox(height: 16),
            const CustomResultHeader(),
            const SizedBox(height: 16),
            const CustomSearchResult(),
          ],
        ),
      ),
    );
  }
}
