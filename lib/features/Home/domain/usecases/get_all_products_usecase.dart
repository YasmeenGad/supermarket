import 'package:dartz/dartz.dart';
import 'package:supermarket/features/Home/data/models/best_selling_products_model.dart';
import 'package:supermarket/features/Home/data/models/product_model.dart';
import '../repositories/product_repository.dart';

typedef GetAllProductsResult= Either<String, List<ProductModel>>;
typedef GetBestSellingProductsResult= Either<String, List<BestSellingProductsModel>>;
class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);


  Future<GetAllProductsResult> getAllProducts() async {
    return await repository.getAllProducts();
  }


  Future<GetBestSellingProductsResult> getBestSellingProducts() async {
    return await repository.getBestSellingProducts();
  }
}
