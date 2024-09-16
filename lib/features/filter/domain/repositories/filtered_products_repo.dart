import 'package:dartz/dartz.dart';
import 'package:supermarket/core/error/failure.dart';
import 'package:supermarket/features/filter/domain/entities/filtered_products.dart';

abstract class FilteredProductsRepository {
  Future<Either<Failure, List<FilteredProducts>>> getProductsByCategory(String categoryName);
}