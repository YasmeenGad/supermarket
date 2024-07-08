import 'package:dartz/dartz.dart';
import 'package:supermarket/features/Home/data/models/best_selling_products_model.dart';
import 'package:supermarket/features/Home/data/models/product_model.dart';


abstract class ProductRepository {
  Future<Either<String, List<ProductModel>>> getAllProducts();
  Future<Either<String, List<BestSellingProductsModel>>> getBestSellingProducts();
}