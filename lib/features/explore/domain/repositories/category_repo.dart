import 'package:dartz/dartz.dart';
import 'package:supermarket/features/explore/domain/entities/category.dart';
import 'package:supermarket/features/explore/domain/entities/searched_category.dart';

abstract class CategoryRepository {
  Future<Either<String, List<Categories>>> getCategories();
  Future<Either<String, SearchedCategory>> getSearchedCategory(String categoryName);
}