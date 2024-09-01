import 'package:dartz/dartz.dart';
import 'package:supermarket/core/error/failure.dart';
import 'package:supermarket/features/Home/domain/entities/best_selling_products.dart';
import 'package:supermarket/features/Home/domain/entities/product.dart';


abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, List<BestSellingProducts>>> getBestSellingProducts();
  Future<Either<Failure, Product>> updateQuantity(String id, int quantity);
}