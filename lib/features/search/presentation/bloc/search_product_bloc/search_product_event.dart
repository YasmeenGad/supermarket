part of 'search_product_bloc.dart';

sealed class SearchProductEvent extends Equatable {
  const SearchProductEvent();

  @override
  List<Object> get props => [];
}

class SearchProduct extends SearchProductEvent {
  final String query;
  const SearchProduct({required this.query}); 

  @override
  List<Object> get props => [query];
}
class ClearSearchEvent extends SearchProductEvent {}
