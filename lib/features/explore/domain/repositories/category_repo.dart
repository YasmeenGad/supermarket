import 'package:dartz/dartz.dart';
import 'package:supermarket/core/error/failure.dart';
import 'package:supermarket/features/explore/domain/entities/category.dart';
import 'package:supermarket/features/explore/domain/entities/searched_category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Categories>>> getCategories();
  Future<Either<Failure, SearchedCategory>> getSearchedCategory(String categoryName);
}