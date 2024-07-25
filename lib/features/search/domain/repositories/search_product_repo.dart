import 'package:dartz/dartz.dart';
import 'package:supermarket/features/search/domain/entities/searched_products.dart';


abstract class SearchProductsRepository {
  Future<Either<String, List<SearchedProducts>>> searchProduct(String productName);
}