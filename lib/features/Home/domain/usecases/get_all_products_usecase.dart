import 'package:dartz/dartz.dart';
import 'package:supermarket/features/Home/data/models/product_model.dart';
import '../repositories/product_repository.dart';

class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  Future<Either<String, List<ProductModel>>> call() async {
    return await repository.getAllProducts();
  }
}
