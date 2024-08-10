// lib/features/favorites/data/repositories/favorites_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/favorite/data/datasources/favorite_remote_datasource.dart';
import 'package:supermarket/features/favorite/domain/entities/favorite_data.dart';
import 'package:supermarket/features/favorite/domain/entities/favorite_entities.dart';
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
  Future<Either<String, AddFavorite>> addFavoriteProducts(
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
        await localDataSource.cacheFavorite(remoteFavorite);
        return Right(remoteFavorite);
      } catch (e) {
        return Left('Failed to get favorite products: $e');
      }
    } else {
      try {
        final localFavorite = await localDataSource.getLastFavorite();
        return Right(localFavorite);
      } catch (e) {
        return Left('No internet connection and no cached data available');
      }
    }
  }
}
