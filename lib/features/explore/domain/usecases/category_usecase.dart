import 'package:dartz/dartz.dart';
import 'package:supermarket/features/explore/domain/entities/category.dart';
import 'package:supermarket/features/explore/domain/entities/searched_category.dart';
import 'package:supermarket/features/explore/domain/repositories/category_repo.dart';

class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Either<dynamic, List<Categories>>> call() async {
    return await repository.getCategories();
  }
  
}
class SearchCategoryUsecase {
  final CategoryRepository repository;

  SearchCategoryUsecase(this.repository);

  Future<Either<String, SearchedCategory>> call(String categoryName) async{
    return await repository.getSearchedCategory(categoryName);
  }
}
