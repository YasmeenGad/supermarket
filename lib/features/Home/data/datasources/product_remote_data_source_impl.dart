import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supermarket/features/Home/data/models/best_selling_products_model.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<List<BestSellingProductsModel>> getBestSellingProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  ProductRemoteDataSourceImpl(
      {required this.client, required this.authLocalDataSource});

  Future<List<ProductModel>> getAllProducts() async {
    final token = await authLocalDataSource.getCachedToken();
    final getAllProductsUrl = Uri.parse('http://10.0.2.2:4000/product/all');
    final response = await client.get(
      getAllProductsUrl,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final products = (data['message'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
      return products;
    } else {
      final errorResponse = jsonDecode(response.body);
      throw ('${errorResponse['message']}');
    }
  }

  @override
  Future<List<BestSellingProductsModel>> getBestSellingProducts() async {
    final token = await authLocalDataSource.getCachedToken();
    final getBestSellingProductsUrl =
        Uri.parse('http://10.0.2.2:4000/product/best');
    final response = await client.get(
      getBestSellingProductsUrl,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final bestSellingProducts = (data['products'] as List)
          .map((product) => BestSellingProductsModel.fromJson(product))
          .toList();
      return bestSellingProducts;
    } else {
      final errorResponse = jsonDecode(response.body);
      throw ('${errorResponse['message']}');
    }
  }
}
