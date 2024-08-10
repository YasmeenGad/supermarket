import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket/features/favorite/data/models/favorite_products_models.dart';

abstract class FavoriteLocalDataSource {
  Future<FavoriteModel> getLastFavorite();
  Future<void> cacheFavorite(FavoriteModel favoriteModel);
}

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final SharedPreferences sharedPreferences;

  FavoriteLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<FavoriteModel> getLastFavorite() {
    final jsonString = sharedPreferences.getString('CACHED_FAVORITE');
    if (jsonString != null) {
      return Future.value(FavoriteModel.fromJson(json.decode(jsonString)));
    } else {
      throw Exception('No favorite cached');
    }
  }

  @override
  Future<void> cacheFavorite(FavoriteModel favoriteModel) {
    return sharedPreferences.setString(
      'CACHED_FAVORITE',json.encode(favoriteModel.toJson()),
    );
  }
}
