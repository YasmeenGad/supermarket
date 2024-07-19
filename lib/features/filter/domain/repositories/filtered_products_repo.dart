import 'package:supermarket/features/filter/domain/entities/filtered_products.dart';

abstract class FilteredProductsRepository {
  Future<List<FilteredProducts>> getProductsByCategory(String categoryName);
}