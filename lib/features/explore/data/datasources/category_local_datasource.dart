// data_sources/category_local_data_source.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket/features/explore/data/models/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getCachedCategories();
  Future<void> cacheCategories(List<CategoryModel> categories);
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final SharedPreferences sharedPreferences;

  CategoryLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CategoryModel>> getCachedCategories() async {
    final jsonString = sharedPreferences.getString('CACHED_CATEGORIES');
    if (jsonString != null) {
      final List<dynamic> jsonMap = json.decode(jsonString);
      return jsonMap.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('No categories cached');
    }
  }

  @override
  Future<void> cacheCategories(List<CategoryModel> categories) async {
    final jsonString =
        json.encode(categories.map((category) => category.toJson()).toList());
    await sharedPreferences.setString('CACHED_CATEGORIES', jsonString);
  }
}
