import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/features/explore/domain/entities/searched_category.dart';
import 'package:supermarket/features/explore/domain/usecases/category_usecase.dart';
part 'search_category_event.dart';
part 'search_category_state.dart';

class SearchCategoryBloc extends Bloc<SearchCategoryEvent, SearchCategoryState> {
  final CategoryUsecase CategoryUseCase;
  SearchCategoryBloc({required this.CategoryUseCase}) : super(SearchCategoryInitial()) {
    on<GetCategoryEvent>(_onGetCategoryEvent);
        on<ClearSearchEvent>((event, emit) {
      emit(SearchCategoryInitial());
    });
  }

  Future<void> _onGetCategoryEvent(GetCategoryEvent event, Emitter<SearchCategoryState> emit) async {
    emit(SearchCategoryLoading());
    final result = await CategoryUseCase.getSearchedCategory(event.categoryName);
    result.fold(
      (failure) => emit(SearchCategoryError(message: failure.message.toString())),
      (category) => emit(SearchCategoryLoaded(category: category)),
    );
  }
}
