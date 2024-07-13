import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supermarket/core/constants/ip.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/search/data/models/searched_products_model.dart';

abstract class SearchRemoteDataSource {
  Future<SearchedProductsModel> searchProduct(String productName);
}
class SearchRemoteDatasourceImpl implements SearchRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;
  SearchRemoteDatasourceImpl({required this.authLocalDataSource, required this.client});
  
  @override
  Future<SearchedProductsModel> searchProduct(String productName) async {
    final token = await authLocalDataSource.getCachedToken();
    final response = await client.post(
      Uri.parse('http://$ip:4000/product/one'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'name': productName}),
    );
    print('Search Product Response: ${response.statusCode} ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        return SearchedProductsModel.fromJson(data['product']);
      } else {
        throw Exception('Failed to load product');
      }
    } else {
      throw Exception('Failed to load product');
    }
  }
}
