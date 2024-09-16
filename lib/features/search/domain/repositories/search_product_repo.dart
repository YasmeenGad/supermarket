import 'package:dartz/dartz.dart';
import 'package:supermarket/core/error/failure.dart';
import 'package:supermarket/features/search/domain/entities/searched_products.dart';


abstract class SearchProductsRepository {
  Future<Either<Failure, List<SearchedProducts>>> searchProduct(String productName);
}