part of 'search_category_bloc.dart';

sealed class SearchCategoryState extends Equatable {
  const SearchCategoryState();
  
  @override
  List<Object> get props => [];
}

final class SearchCategoryInitial extends SearchCategoryState {}

class SearchCategoryLoading extends SearchCategoryState {}

class SearchCategoryLoaded extends SearchCategoryState {
  final SearchedCategory category;

  SearchCategoryLoaded({required this.category});

  @override
  List<Object> get props => [category];
}

class SearchCategoryError extends SearchCategoryState {
  final String message;

  SearchCategoryError({required this.message});

  @override
  List<Object> get props => [message];
}
