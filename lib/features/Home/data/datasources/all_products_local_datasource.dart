// data/datasources/auth_local_datasource.dart
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket/features/Home/data/models/best_selling_products_model.dart';
import 'package:supermarket/features/Home/data/models/product_model.dart';

abstract class AllProductsLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>> getCachedProducts();
  Future<void> cacheBestSellingProducts(
      List<BestSellingProductsModel> products);
  Future<List<BestSellingProductsModel>> getCachedBestSellingProducts();
}

class AllProductsLocalDataSourceImpl implements AllProductsLocalDataSource {
  static const CASHED_PRODUCTS = 'CACHED_PRODUCTS';
  static const CASHED_BEST_SELLING_PRODUCTS = 'CASHED_BEST_SELLING_PRODUCTS';
  final SharedPreferences sharedPreferences;

  AllProductsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final productsJson = products.map((product) => product.toJson()).toList();
    await sharedPreferences.setString(
        CASHED_PRODUCTS, json.encode(productsJson));
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final jsonString = await sharedPreferences.getString(CASHED_PRODUCTS);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> cacheBestSellingProducts(
      List<BestSellingProductsModel> products) async {
    final productsJson = products.map((product) => product.toJson()).toList();
    await sharedPreferences.setString(
        CASHED_BEST_SELLING_PRODUCTS, json.encode(productsJson));
  }

  @override
  Future<List<BestSellingProductsModel>> getCachedBestSellingProducts() async {
    final jsonString =
        await sharedPreferences.getString(CASHED_BEST_SELLING_PRODUCTS);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => BestSellingProductsModel.fromJson(json))
          .toList();
    } else {
      return [];
    }
  }
}
