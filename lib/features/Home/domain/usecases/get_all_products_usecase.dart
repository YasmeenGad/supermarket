import 'package:dartz/dartz.dart';

import 'package:supermarket/features/Home/domain/entities/best_selling_products.dart';
import 'package:supermarket/features/Home/domain/entities/product.dart';
import '../repositories/product_repository.dart';

typedef GetAllProductsResult= Either<String, List<Product>>;
typedef GetBestSellingProductsResult= Either<String, List<BestSellingProducts>>;
typedef UpdateQuantityResult= Either<String, Product>;
class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);


  Future<GetAllProductsResult> getAllProducts() async {
    return await repository.getAllProducts();
  }


  Future<GetBestSellingProductsResult> getBestSellingProducts() async {
    return await repository.getBestSellingProducts();
  }


  Future<UpdateQuantityResult> updateQuantity(String id, int quantity) async {
    return await repository.updateQuantity(id, quantity);
  }
}
