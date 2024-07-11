import 'package:dartz/dartz.dart';
import 'package:supermarket/features/search/data/models/searched_products_model.dart';


abstract class SearchProductsRepository {
  Future<Either<String, SearchedProductsModel>> searchProduct(String productName);
}