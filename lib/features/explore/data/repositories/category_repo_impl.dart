import 'package:dartz/dartz.dart';
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
  Future<Either<dynamic, List<Categories>>> getCategories() async {
    if (!await networkInfo.isConnected) {
      return await left(localDataSource.getCachedCategories());
    }
    try {
      final remoteCategories = await remoteDataSource.getAllCategories();
      localDataSource.cacheCategories(remoteCategories);
      return right(remoteCategories);
    } catch (e) {
      return left('Failed to get categories: $e');
    }
  }

  @override
  Future<Either<String, SearchedCategory>> getSearchedCategory(
      String categoryName) async {
    if (!await networkInfo.isConnected) {
      return left('No internet connection');
    }
    try {
      final remoteCategory =
          await remoteDataSource.getSearchedCategory(categoryName);
      return Right(remoteCategory);
    } catch (e) {
      return Left("Failed to get category: $e");
    }
  }

  // @override
  // Future<Either<String, SearchedCategory>> getSearchedCategory(String categoryName) async{
  //   if (!await networkInfo.isConnected) {
  //     return left('No internet connection');
  //   }
  //   try {
  //     final remoteCategory = remoteDataSource.getCategory(categoryName);
  //     return Right(remoteCategory as SearchedCategory);
  //   } catch (e) {
  //     return left('Failed to get category: $e');
  //   }
  // }
}
