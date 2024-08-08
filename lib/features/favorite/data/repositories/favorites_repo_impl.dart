// lib/features/favorites/data/repositories/favorites_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/favorite/data/datasources/favorite_remote_datasource.dart';
import 'package:supermarket/features/favorite/domain/entities/favorite_data.dart';
import 'package:supermarket/features/favorite/domain/repositories/favorites_repo.dart';

import '../datasources/favorites_local_data_source.dart';


class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource remoteDataSource;
  final FavoritesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  FavoritesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<String, Favorites>> addFavoriteProducts(List<String> productIds) async {
    if (await networkInfo.isConnected) {
      try {
        final addedFavorites = await remoteDataSource.addFavoriteProducts(productIds);
        localDataSource.cacheFavoriteProducts(addedFavorites);
        return Right(addedFavorites.toEntity());
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      try {
        final cachedFavorites = await localDataSource.getLastFavoriteProducts();
        return cachedFavorites != null ? Right(cachedFavorites.toEntity()) : Left('No internet connection');
      } catch (e) {
        return Left(e.toString());
      }
    }
  }
  
}
