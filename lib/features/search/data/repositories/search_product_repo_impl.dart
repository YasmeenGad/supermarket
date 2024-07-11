import 'package:dartz/dartz.dart';
import 'package:supermarket/features/search/data/datasources/search_remote_datasource.dart';
import 'package:supermarket/features/search/data/models/searched_products_model.dart';
import 'package:supermarket/features/search/domain/repositories/search_product_repo.dart';

class SearchProductsRepositoryImpl implements SearchProductsRepository {
  final SearchRemoteDataSource searchRemoteDatasource;

  SearchProductsRepositoryImpl({required this.searchRemoteDatasource});

  @override
  Future<Either<String, SearchedProductsModel>> searchProduct(
      String productName) async {
    try {
      final product = await searchRemoteDatasource.searchProduct(productName);
      print(product);
      return Right(product);
    } catch (error) {
      return Left(error.toString());
    }
  }
}
