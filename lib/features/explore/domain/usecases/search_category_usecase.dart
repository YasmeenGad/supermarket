import 'package:dartz/dartz.dart';
import 'package:supermarket/features/explore/domain/entities/searched_category.dart';
import 'package:supermarket/features/explore/domain/repositories/search_category_repo.dart';

class SearchCategoryUsecase {
  final SearchCategoryRepository repository;

  SearchCategoryUsecase(this.repository);

  Future<Either<String, SearchedCategory>> call(String categoryName) {
    return repository.getCategory(categoryName);
  }
}