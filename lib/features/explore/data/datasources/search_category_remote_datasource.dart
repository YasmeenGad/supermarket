// lib/data/datasources/category_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supermarket/core/constants/ip.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/explore/data/models/searched_category_model.dart';

abstract class SearchCategoryRemoteDatasource {
  Future<SearchedCategoryModel> getCategory(String categoryName);
}

class SearchCategoryRemoteDatasourceImpl
    implements SearchCategoryRemoteDatasource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;
  SearchCategoryRemoteDatasourceImpl(
      {required this.authLocalDataSource, required this.client});

  @override
  Future<SearchedCategoryModel> getCategory(String categoryName) async {
    final token = await authLocalDataSource.getCachedLoginResponse();
    final response = await client.get(
      Uri.parse('http://$ip:4000/category/$categoryName'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token?.token ?? ''}',
      },
    );

    if (response.statusCode == 200) {
      return SearchedCategoryModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load category');
    }
  }
}
