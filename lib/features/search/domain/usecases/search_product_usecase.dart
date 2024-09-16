import 'package:dartz/dartz.dart';
import 'package:supermarket/core/error/failure.dart';
import 'package:supermarket/features/search/domain/entities/searched_products.dart';
import 'package:supermarket/features/search/domain/repositories/search_product_repo.dart';

class SearchProductUsecase{

  final SearchProductsRepository searchProductsRepository;

  SearchProductUsecase({required this.searchProductsRepository});

  Future<Either<Failure, List<SearchedProducts>>> call(String productName) async {
    return await searchProductsRepository.searchProduct(productName);
  }
}