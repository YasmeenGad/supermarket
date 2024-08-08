import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket/features/favorite/data/models/get_fav_model.dart';

abstract class FavoriteLocalDataSource {
  Future<FavoriteProductsModel> getLastFavorite();
  Future<void> cacheFavorite(FavoriteProductsModel favoriteModel);
}

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final SharedPreferences sharedPreferences;

  FavoriteLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<FavoriteProductsModel> getLastFavorite() {
    final jsonString = sharedPreferences.getString('CACHED_FAVORITE');
    if (jsonString != null) {
      return Future.value(FavoriteProductsModel.fromJson(json.decode(jsonString)));
    } else {
      throw Exception('No favorite cached');
    }
  }

  @override
  Future<void> cacheFavorite(FavoriteProductsModel favoriteModel) {
    return sharedPreferences.setString(
      'CACHED_FAVORITE',json.encode(favoriteModel.toJson()),
    );
  }
}
