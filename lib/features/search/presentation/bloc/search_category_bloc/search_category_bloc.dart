import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/features/search/domain/entities/searched_category.dart';
import 'package:supermarket/features/search/domain/usecases/search_category_usecase.dart';

part 'search_category_event.dart';
part 'search_category_state.dart';

class SearchCategoryBloc extends Bloc<SearchCategoryEvent, SearchCategoryState> {
  final SearchCategoryUsecase CategoryUseCase;
  SearchCategoryBloc({required this.CategoryUseCase}) : super(SearchCategoryInitial()) {
    on<GetCategoryEvent>(_onGetCategoryEvent);
  }

  Future<void> _onGetCategoryEvent(GetCategoryEvent event, Emitter<SearchCategoryState> emit) async {
    emit(CategoryLoading());
    final result = await CategoryUseCase(event.categoryName);
    result.fold(
      (failure) => emit(CategoryError(message: failure.toString())),
      (category) => emit(CategoryLoaded(category: category)),
    );
  }
}
