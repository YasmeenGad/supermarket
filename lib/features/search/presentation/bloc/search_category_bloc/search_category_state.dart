part of 'search_category_bloc.dart';

sealed class SearchCategoryState extends Equatable {
  const SearchCategoryState();
  
  @override
  List<Object> get props => [];
}

final class SearchCategoryInitial extends SearchCategoryState {}

class CategoryLoading extends SearchCategoryState {}

class CategoryLoaded extends SearchCategoryState {
  final SearchedCategory category;

  CategoryLoaded({required this.category});

  @override
  List<Object> get props => [category];
}

class CategoryError extends SearchCategoryState {
  final String message;

  CategoryError({required this.message});

  @override
  List<Object> get props => [message];
}
