import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:supermarket/core/error/exceptions.dart';
import 'package:supermarket/core/error/failure.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/favorite/data/datasources/favorite_local_datasource.dart';
import 'package:supermarket/features/favorite/data/datasources/favorite_remote_datasource.dart';
import 'package:supermarket/features/favorite/data/models/get_favorite_model.dart';
import 'package:supermarket/features/favorite/domain/entities/add_favorite.dart';
import 'package:supermarket/features/favorite/domain/entities/delete_all_favorite_products.dart';
import 'package:supermarket/features/favorite/domain/entities/delete_one_favorite_product.dart';
import 'package:supermarket/features/favorite/domain/entities/get_favorite.dart';
import 'package:supermarket/features/favorite/domain/repositories/favorite_repo.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource remoteDataSource;
  final FavoriteLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  FavoriteRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, AddFavorite>> addFavoriteProducts(
      List<String> productIds) async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final favorite = await remoteDataSource.addFavoriteProducts(productIds);
      return Right(favorite);
    } on ServerException catch (e) {
      if (e.statusCode >= 500) {
        return const Left(InternalServerErrorFailure());
      }
      return Left(ServerFailure(e.message, e.statusCode));
    } on TimeoutException {
      return const Left(TimeoutFailure());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetFavorite>> getFavoriteProducts() async {
    if (!await networkInfo.isConnected) {
      try {
        final cachedFavorite =
            await localDataSource.getCachedFavoriteProducts();
        if (cachedFavorite != null) {
          return Right(cachedFavorite);
        } else {
          return const Left(CacheFailure());
        }
      } catch (e) {
        return Left(GeneralFailure(e.toString()));
      }
    }
    try {
      final favorite = await remoteDataSource.getFavoriteProducts();
      await localDataSource.cacheFavoriteProducts(favorite);
      return Right(favorite);
    } on ServerException catch (e) {
      if (e.statusCode >= 500) {
        return const Left(InternalServerErrorFailure());
      }
      return Left(ServerFailure(e.message, e.statusCode));
    } on TimeoutException {
      return const Left(TimeoutFailure());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteOneFavoriteProduct>> deleteOneFavoriteProduct(
      List<String> productIds) async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final result =
          await remoteDataSource.deleteOneFavoriteProduct(productIds);

      // Update cache after successful deletion
      final cachedFavorite = await localDataSource.getCachedFavoriteProducts();
      if (cachedFavorite != null) {
        final updatedProducts = cachedFavorite.products
            .where((product) => !productIds.contains(product.id))
            .toList();
        final updatedFavorite = cachedFavorite.copyWith(
            products: updatedProducts as List<GetFavoriteProductModel>);
        await localDataSource.cacheFavoriteProducts(updatedFavorite);
      }

      return Right(result);
    } on ServerException catch (e) {
      if (e.statusCode >= 500) {
        return const Left(InternalServerErrorFailure());
      }
      return Left(ServerFailure(e.message, e.statusCode));
    } on TimeoutException {
      return const Left(TimeoutFailure());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteAllFavoritesProducts>>
      deleteAllFavoritesProducts() async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final result = await remoteDataSource.deleteAllFavoriteProducts();
      return Right(result);
    } on ServerException catch (e) {
      if (e.statusCode >= 500) {
        return const Left(InternalServerErrorFailure());
      }
      return Left(ServerFailure(e.message, e.statusCode));
    } on TimeoutException {
      return const Left(TimeoutFailure());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
