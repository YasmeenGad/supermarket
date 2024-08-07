// lib/features/favorites/data/datasources/favorites_local_data_source.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket/features/favorite/data/models/favorite_data_model.dart';

abstract class FavoritesLocalDataSource {
  Future<FavoriteModel?> getLastFavoriteProducts();
  Future<void> cacheFavoriteProducts(FavoriteModel favoriteToCache);
}

const CACHED_FAVORITE_PRODUCTS = 'CACHED_FAVORITE_PRODUCTS';

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final SharedPreferences sharedPreferences;

  FavoritesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<FavoriteModel?> getLastFavoriteProducts() {
    final jsonString = sharedPreferences.getString(CACHED_FAVORITE_PRODUCTS);
    if (jsonString != null) {
      return Future.value(FavoriteModel.fromJson(json.decode(jsonString)));
    } else {
      return Future.value(null);
    }
  }

  @override
  Future<void> cacheFavoriteProducts(FavoriteModel favoriteToCache) {
    return sharedPreferences.setString(
      CACHED_FAVORITE_PRODUCTS,
      json.encode(favoriteToCache.toJson()),
    );
  }
}
