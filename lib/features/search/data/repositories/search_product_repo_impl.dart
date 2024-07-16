import 'package:dartz/dartz.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/search/data/datasources/search_remote_datasource.dart';
import 'package:supermarket/features/search/data/models/searched_products_model.dart';
import 'package:supermarket/features/search/domain/repositories/search_product_repo.dart';

class SearchProductsRepositoryImpl implements SearchProductsRepository {
  final SearchRemoteDataSource searchRemoteDatasource;
   final NetworkInfo networkInfo;
  SearchProductsRepositoryImpl({required this.networkInfo, required this.searchRemoteDatasource});

  @override
  Future<Either<String, SearchedProductsModel>> searchProduct(
      String productName) async {
   if(!await networkInfo.isConnected){
     return Left('No Internet Connection');
   }
    try {
      final product = await searchRemoteDatasource.searchProduct(productName);
      print(product);
      return Right(product);
    } catch (error) {
      return Left(error.toString());
    }
  }
}
