part of 'filtered_products_bloc.dart';

sealed class FilteredProductsEvent extends Equatable {
  const FilteredProductsEvent();

  @override
  List<Object> get props => [];
}

class GetProductsByCategoryEvent extends FilteredProductsEvent {
  final String categoryName;

  const GetProductsByCategoryEvent({required this.categoryName});

  @override
  List<Object> get props => [categoryName];
}
