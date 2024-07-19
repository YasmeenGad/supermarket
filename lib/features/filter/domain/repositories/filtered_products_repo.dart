import 'package:dartz/dartz.dart';
import 'package:supermarket/features/filter/domain/entities/filtered_products.dart';

abstract class FilteredProductsRepository {
  Future<Either<String, List<FilteredProducts>>> getProductsByCategory(String categoryName);
}