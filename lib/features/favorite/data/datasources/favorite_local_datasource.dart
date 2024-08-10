import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:supermarket/features/favorite/data/models/get_favorite_model.dart';

abstract class FavoriteLocalDataSource {
  Future<void> cacheFavoriteProducts(GetFavoriteModel favoriteModel);
  Future<GetFavoriteModel?> getCachedFavoriteProducts();
  Future<void> clearCachedFavoriteProducts();
}

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final SharedPreferences _sharedPreferences;
  static const String _cachedFavoriteProductsKey = 'CACHED_FAVORITE_PRODUCTS';

  FavoriteLocalDataSourceImpl({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  @override
  Future<void> cacheFavoriteProducts(GetFavoriteModel favoriteModel) async {
    final jsonString = json.encode(favoriteModel.toJson());
    await _sharedPreferences.setString(_cachedFavoriteProductsKey, jsonString);
  }

  @override
  Future<GetFavoriteModel?> getCachedFavoriteProducts() async {
    final jsonString = _sharedPreferences.getString(_cachedFavoriteProductsKey);
    if (jsonString != null) {
      return GetFavoriteModel.fromJson(json.decode(jsonString));
    }
    return null;
  }

  @override
  Future<void> clearCachedFavoriteProducts() async {
    await _sharedPreferences.remove(_cachedFavoriteProductsKey);
  }
}
