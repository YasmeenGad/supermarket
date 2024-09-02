import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:supermarket/core/error/exceptions.dart';
import 'package:supermarket/core/error/failure.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/explore/data/datasources/category_local_datasource.dart';
import 'package:supermarket/features/explore/data/datasources/category_remote_datasource.dart';
import 'package:supermarket/features/explore/domain/entities/category.dart';
import 'package:supermarket/features/explore/domain/entities/searched_category.dart';
import 'package:supermarket/features/explore/domain/repositories/category_repo.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  final CategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Categories>>> getCategories() async {
    if (!await networkInfo.isConnected) {
      try {
        final cachedCategories = await localDataSource.getCachedCategories();
        return right(cachedCategories);
      } on CacheException {
        return left(CacheFailure());
      } catch (e) {
        return left(GeneralFailure(e.toString()));
      }
    }
    try {
      final remoteCategories = await remoteDataSource.getAllCategories();
      localDataSource.cacheCategories(remoteCategories);
      return right(remoteCategories);
    } on ServerException catch (e) {
      if (e.statusCode >= 500) {
        return left(InternalServerErrorFailure());
      }
      return left(ServerFailure(e.message, e.statusCode));
    } on TimeoutException {
      return left(TimeoutFailure());
    } catch (e) {
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SearchedCategory>> getSearchedCategory(
      String categoryName) async {
    if (!await networkInfo.isConnected) {
      return left(NoInternetFailure());
    }
    try {
      final remoteCategory =
          await remoteDataSource.getSearchedCategory(categoryName);
      return right(remoteCategory);
    } on ServerException catch (e) {
      if (e.statusCode >= 500) {
        return left(InternalServerErrorFailure());
      }
      return left(ServerFailure(e.message, e.statusCode));
    } on TimeoutException {
      return left(TimeoutFailure());
    } catch (e) {
      return left(GeneralFailure(e.toString()));
    }
  }
}
