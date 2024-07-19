// category_local_data_source.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket/features/filter/data/models/filtered_products_model.dart';

abstract class FilteredProductsLocalDatasource {
  Future<List<FilteredProductsModel>> getLastProductsByCategory();
  Future<void> cacheProductsByCategory(List<FilteredProductsModel> products);
}

const CACHED_CATEGORY_PRODUCTS = 'CACHED_CATEGORY_PRODUCTS';

class CategoryLocalDataSourceImpl implements FilteredProductsLocalDatasource {
  final SharedPreferences sharedPreferences;

  CategoryLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<FilteredProductsModel>> getLastProductsByCategory() {
    final jsonString = sharedPreferences.getString(CACHED_CATEGORY_PRODUCTS);
    if (jsonString != null) {
      List<FilteredProductsModel> products = (json.decode(jsonString) as List)
          .map((product) => FilteredProductsModel.fromJson(product))
          .toList();
      return Future.value(products);
    } else {
      throw Exception('No cached data found');
    }
  }

  @override
  Future<void> cacheProductsByCategory(List<FilteredProductsModel> products) {
    final jsonString = json.encode(products.map((product) => product.toJson()).toList());
    return sharedPreferences.setString(CACHED_CATEGORY_PRODUCTS, jsonString);
  }
}
