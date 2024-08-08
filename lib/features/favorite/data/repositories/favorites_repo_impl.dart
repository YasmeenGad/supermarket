// lib/features/favorites/data/repositories/favorites_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/favorite/data/datasources/favorite_remote_datasource.dart';
import 'package:supermarket/features/favorite/domain/entities/fav_products.dart';
import 'package:supermarket/features/favorite/domain/entities/favorite_data.dart';
import 'package:supermarket/features/favorite/domain/repositories/favorites_repo.dart';

import '../datasources/favorites_local_data_source.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource remoteDataSource;
  final FavoriteLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  FavoritesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<String, Favorites>> addFavoriteProducts(
      List<String> productIds) async {
    if (!await networkInfo.isConnected) {
      return Left('No internet connection');
    }
    try {
      final addedFavorites =
          await remoteDataSource.addFavoriteProducts(productIds);
      return Right(addedFavorites.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Favorite>> getFavoriteProducts(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteFavorite = await remoteDataSource.getFavoriteProducts(id);
        localDataSource.cacheFavorite(remoteFavorite);
        return Right(remoteFavorite.toEntity());
      } catch (e) {
        throw left('Failed to get favorite products');
      }
    } else {
      try {
        final localFavorite = await localDataSource.getLastFavorite();
        return Right(localFavorite.toEntity());
      } catch (e) {
        throw left('No internet connection and no cached data available');
      }
    }
  }
}
