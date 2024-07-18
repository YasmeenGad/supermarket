part of 'search_category_bloc.dart';

sealed class SearchCategoryEvent extends Equatable {
  const SearchCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCategoryEvent extends SearchCategoryEvent {
  final String categoryName;

  GetCategoryEvent({required this.categoryName});

  @override
  List<Object> get props => [categoryName];
}
