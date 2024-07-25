import 'package:dartz/dartz.dart';
import 'package:supermarket/features/explore/domain/entities/searched_category.dart';

abstract class SearchCategoryRepository {
  Future<Either<String, SearchedCategory>> getCategory(String categoryName);
}