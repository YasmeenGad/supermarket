import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/filter/presentation/widgets/filtered_products_view_body.dart';

class FilteredProductsView extends StatelessWidget {
  FilteredProductsView({super.key, required this.categoryName});
  String categoryName;

  @override
  Widget build(BuildContext context) {
    categoryName = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: darkColor,
          ),
        ),
        title: Text(
          '${categoryName}',
          style: AppStyles.styleSemiBold20(context).copyWith(color: darkColor),
        ),
        centerTitle: true,
      ),
      body: FilteredProductsViewBody(
        categoryName: categoryName,
      ),
    );
  }
}
