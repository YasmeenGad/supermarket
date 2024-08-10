import 'package:dartz/dartz.dart';
import 'package:supermarket/features/favorite/domain/entities/favorite_data.dart';
import 'package:supermarket/features/favorite/domain/entities/favorite_entities.dart';

abstract class FavoritesRepository {
  Future<Either<String, AddFavorite>> addFavoriteProducts(
      List<String> productIds);

  Future<Either<String, Favorite>> getFavoriteProducts(String id);
}
