import 'package:dartz/dartz.dart';
import 'package:supermarket/features/filter/domain/entities/filtered_products.dart';
import 'package:supermarket/features/filter/domain/repositories/filtered_products_repo.dart';

class FilteredProductsUsecase {
  final FilteredProductsRepository repository;

  FilteredProductsUsecase(this.repository);

  Future<Either<String, List<FilteredProducts>>> call(String categoryName) async {
    return await repository.getProductsByCategory(categoryName);
  }
}