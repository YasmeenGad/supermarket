import 'package:dartz/dartz.dart';
import 'package:supermarket/core/error/failure.dart';
import 'package:supermarket/features/explore/domain/entities/category.dart';
import 'package:supermarket/features/explore/domain/entities/searched_category.dart';
import 'package:supermarket/features/explore/domain/repositories/category_repo.dart';


typedef CategoryResult = Either<Failure, List<Categories>>;
typedef SearchedCategoryResult = Either<Failure, SearchedCategory>;

class CategoryUsecase{
  CategoryRepository categoryRepository;

  CategoryUsecase(this.categoryRepository);

  Future<CategoryResult> getCategories() async {
    return await categoryRepository.getCategories();
  }

  Future<SearchedCategoryResult> getSearchedCategory(String categoryName) async{
    return await categoryRepository.getSearchedCategory(categoryName);
  }
}
