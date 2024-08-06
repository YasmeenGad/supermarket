import 'package:dartz/dartz.dart';
import 'package:supermarket/features/filter/domain/entities/filtered_products.dart';
import 'package:supermarket/features/filter/domain/repositories/filtered_products_repo.dart';

typedef GetProductsByCategory = Either<String, List<FilteredProducts>>;
class FilteredProductsUsecase {
  final FilteredProductsRepository repository;

  FilteredProductsUsecase(this.repository);

  Future<GetProductsByCategory> getProductsByCategory(String categoryName) async {
    return await repository.getProductsByCategory(categoryName);
  }
}