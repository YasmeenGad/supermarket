import 'package:dartz/dartz.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/search/data/datasources/search_category_remote_datasource.dart';
import 'package:supermarket/features/search/domain/entities/searched_category.dart';
import 'package:supermarket/features/search/domain/repositories/search_category_repo.dart';

class SearchCategoryRepoImpl implements SearchCategoryRepository {
  final SearchCategoryRemoteDatasource searchCategoryRemoteDatasource;
  final NetworkInfo networkInfo;

  SearchCategoryRepoImpl({
    required this.searchCategoryRemoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<String, SearchedCategory>> getCategory(String categoryName) async{
     try {
      final remoteCategory = await searchCategoryRemoteDatasource.getCategory(categoryName);
      return Right(remoteCategory);
    } catch (e) {
      return Left("Failed to get category: $e");
    }
  }
}