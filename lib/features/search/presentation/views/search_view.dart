import 'package:flutter/material.dart';
import 'package:supermarket/features/search/presentation/widgets/custom_search.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     
      body: CustomSearch(),
    );
  }
}