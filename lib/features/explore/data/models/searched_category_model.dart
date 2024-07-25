import 'package:supermarket/features/explore/domain/entities/searched_category.dart';

class SearchedCategoryModel extends SearchedCategory {
  SearchedCategoryModel({required String categoryName, required String imageUrl}) : super(categoryName: categoryName, imageUrl: imageUrl);

  factory SearchedCategoryModel.fromJson(Map<String, dynamic> json) {
    return SearchedCategoryModel(
      categoryName: json['message']['categoryName'],
      imageUrl: json['message']['photo'],
    );
  }
}