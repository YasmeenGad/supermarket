import 'package:dartz/dartz.dart';
import 'package:supermarket/features/explore/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<Either<dynamic, List<Categories>>> getCategories();
}