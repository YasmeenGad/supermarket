import 'package:dartz/dartz.dart';
import 'package:supermarket/features/Home/data/models/best_selling_products_model.dart';
import '../repositories/product_repository.dart';

class GetBestSellingProductUsecase {
  final ProductRepository repository;

  GetBestSellingProductUsecase(this.repository);

  Future<Either<String, List<BestSellingProductsModel>>> call() async {
    return await repository.getBestSellingProducts();
  }
}
