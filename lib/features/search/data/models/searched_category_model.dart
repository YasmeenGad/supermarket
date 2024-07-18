import 'package:supermarket/features/search/domain/entities/searched_category.dart';

class SearchedCategoryModel extends SearchedCategory {
  SearchedCategoryModel({required String categoryName}) : super(categoryName: categoryName);

  factory SearchedCategoryModel.fromJson(Map<String, dynamic> json) {
    return SearchedCategoryModel(
      categoryName: json['message']['categoryName'],
    );
  }
}