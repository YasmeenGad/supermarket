import 'package:supermarket/features/explore/domain/entities/category.dart';

class CategoryModel extends Categories {
  final String categoryName;

  CategoryModel({required this.categoryName})
      : super(categoryName: categoryName);

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryName: json['categoryName'],
      );
       Map<String, dynamic> toJson() {
    return {
      'categoryName': categoryName,
    };
  }
}
