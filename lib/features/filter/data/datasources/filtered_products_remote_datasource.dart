
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supermarket/core/constants/ip.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/filter/data/models/filtered_products_model.dart';

abstract class FilteredProductsRemoteDatasource {
  Future<List<FilteredProductsModel>> getProductsByCategory(
      String categoryName);
}

class FilteredProductsRemoteDatasourceImpl implements FilteredProductsRemoteDatasource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  FilteredProductsRemoteDatasourceImpl(
      {required this.authLocalDataSource, required this.client});

  @override
  Future<List<FilteredProductsModel>> getProductsByCategory(
      String categoryName) async {
    final token = await authLocalDataSource.getCachedToken();
    final response = await client.post(
      Uri.parse('http://$ip:4000/category/filter'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'categoryName': categoryName}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == true) {
        List<FilteredProductsModel> products =
            (jsonResponse['products'] as List)
                .map((product) => FilteredProductsModel.fromJson(product))
                .toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } else {
      throw Exception('Failed to load products');
    }
  }
}
