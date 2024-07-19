part of 'filtered_products_bloc.dart';

sealed class FilteredProductsState extends Equatable {
  const FilteredProductsState();

  @override
  List<Object> get props => [];
}

final class FilteredProductsInitial extends FilteredProductsState {}

class FilteredProductsLoading extends FilteredProductsState {}

class FilteredProductsLoaded extends FilteredProductsState {
  final List<FilteredProducts> products;

  const FilteredProductsLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class FilteredProductsError extends FilteredProductsState {
  final String message;

  const FilteredProductsError({required this.message});

  @override
  List<Object> get props => [message];
}
