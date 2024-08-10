import 'package:dartz/dartz.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/favorite/data/datasources/favorite_remote_datasource.dart';
import 'package:supermarket/features/favorite/domain/entities/add_favorite.dart';
import 'package:supermarket/features/favorite/domain/repositories/favorite_repo.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FavoriteRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

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
}
