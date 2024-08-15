import 'package:dartz/dartz.dart';
import 'package:supermarket/features/Home/domain/entities/best_selling_products.dart';
import 'package:supermarket/features/Home/domain/entities/product.dart';


abstract class ProductRepository {
  Future<Either<String, List<Product>>> getAllProducts();
  Future<Either<String, List<BestSellingProducts>>> getBestSellingProducts();
  Future<Either<String, List<Product>>> updateQuantity(String id, int quantity);
}