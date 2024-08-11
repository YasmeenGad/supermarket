import 'package:dartz/dartz.dart';
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

  FavoriteRepositoryImpl(
      {required this.remoteDataSource,
      required this.networkInfo,
      required this.localDataSource});

  @override
  Future<Either<String, AddFavorite>> addFavoriteProducts(
      List<String> productIds) async {
    if (!await networkInfo.isConnected) {
      return const Left('No internet connection');
    }
    try {
      final favorite = await remoteDataSource.addFavoriteProducts(productIds);
      return Right(favorite);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, GetFavorite>> getFavoriteProducts() async {
    if (!await networkInfo.isConnected) {
      try {
        final cachedFavorite =
            await localDataSource.getCachedFavoriteProducts();
        if (cachedFavorite != null) {
          return Right(cachedFavorite);
        } else {
          return const Left(
              'No Internet Connection and No Cached Data Available');
        }
      } catch (e) {
        return Left(e.toString());
      }
    }
    try {
      final favorite = await remoteDataSource.getFavoriteProducts();
      await localDataSource.cacheFavoriteProducts(favorite);
      return Right(favorite);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, DeleteOneFavoriteProduct>> deleteOneFavoriteProduct(
      List<String> productIds) async {
    if (!await networkInfo.isConnected) {
      print('no internet connection');
      return const Left('No internet connection');
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
      print('deleted successfully');

      return Right(result);
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, DeleteAllFavoritesProducts>>
      deleteAllFavoritesProducts() async {
    if (!await networkInfo.isConnected) {
      return const Left('No internet connection');
    }
    try {
      final result = await remoteDataSource.deleteAllFavoriteProducts();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
