import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:supermarket/core/error/exceptions.dart';
import 'package:supermarket/core/error/failure.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/search/data/datasources/search_remote_datasource.dart';
import 'package:supermarket/features/search/domain/entities/searched_products.dart';
import 'package:supermarket/features/search/domain/repositories/search_product_repo.dart';

class SearchProductsRepositoryImpl implements SearchProductsRepository {
  final SearchRemoteDataSource searchRemoteDatasource;
  final NetworkInfo networkInfo;
  SearchProductsRepositoryImpl(
      {required this.networkInfo, required this.searchRemoteDatasource});

  @override
  Future<Either<Failure, List<SearchedProducts>>> searchProduct(
      String productName) async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final product = await searchRemoteDatasource.searchProduct(productName);
      print(product);
      return Right(product);
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
