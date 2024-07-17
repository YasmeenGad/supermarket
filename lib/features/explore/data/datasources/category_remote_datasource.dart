import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supermarket/core/constants/ip.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/explore/data/models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getAllCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  CategoryRemoteDataSourceImpl(
      {required this.authLocalDataSource, required this.client});

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final token = await authLocalDataSource.getCachedToken();
    final response = await client.get(
      Uri.parse('http://$ip:4000/category/all'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final categories = (decodedJson['categories'] as List)
          .map((categoryJson) => CategoryModel.fromJson(categoryJson))
          .toList();
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
