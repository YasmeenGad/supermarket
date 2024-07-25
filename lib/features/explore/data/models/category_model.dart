import 'package:supermarket/features/explore/domain/entities/category.dart';

class CategoryModel extends Categories {
  final String categoryName;
  final String imageUrl;

  CategoryModel({required this.imageUrl, required this.categoryName})
      : super(categoryName: categoryName, imageUrl: imageUrl);

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryName: json['categoryName'],
        imageUrl: json['photo'],
      );
  Map<String, dynamic> toJson() {
    return {'categoryName': categoryName, 'photo': imageUrl};
  }
}
