import 'package:dartz/dartz.dart';
import 'package:supermarket/core/error/failure.dart';
import 'package:supermarket/features/favorite/domain/entities/add_favorite.dart';
import 'package:supermarket/features/favorite/domain/entities/delete_all_favorite_products.dart';
import 'package:supermarket/features/favorite/domain/entities/delete_one_favorite_product.dart';
import 'package:supermarket/features/favorite/domain/entities/get_favorite.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, AddFavorite>> addFavoriteProducts(List<String> productIds);
  Future<Either<Failure, GetFavorite>> getFavoriteProducts();
  Future<Either<Failure, DeleteOneFavoriteProduct>> deleteOneFavoriteProduct(List<String> productIds);
  Future<Either<Failure, DeleteAllFavoritesProducts>> deleteAllFavoritesProducts();
}