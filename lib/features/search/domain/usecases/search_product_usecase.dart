import 'package:dartz/dartz.dart';
import 'package:supermarket/features/search/data/models/searched_products_model.dart';
import 'package:supermarket/features/search/domain/repositories/search_product_repo.dart';

class SearchProductUsecase{

  final SearchProductsRepository searchProductsRepository;

  SearchProductUsecase({required this.searchProductsRepository});

  Future<Either<String, SearchedProductsModel>> call(String productName) async {
    return await searchProductsRepository.searchProduct(productName);
  }
}