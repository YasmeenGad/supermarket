import 'package:dartz/dartz.dart';
import 'package:supermarket/features/favorite/domain/entities/favorite_data.dart';

abstract class FavoritesRepository {
  Future<Either<String, Favorites>> addFavoriteProducts(
      List<String> productIds);
}
