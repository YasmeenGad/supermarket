import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/features/favorite/domain/entities/favorite_data.dart';
import 'package:supermarket/features/favorite/domain/usecases/favorites_usecase.dart';

part 'add_favorite_event.dart';
part 'add_favorite_state.dart';

class AddFavoriteBloc extends Bloc<AddFavoriteEvent, AddFavoriteState> {
  final FavoritesUsecase favoritesUsecase;
  AddFavoriteBloc(this.favoritesUsecase) : super(AddFavoriteInitial()) {
    on<AddFavorite>(_addFavorite);
  }

  Future<void> _addFavorite(
      AddFavorite event, Emitter<AddFavoriteState> emit) async {
    emit(AddFavoriteLoading());
    final result = await favoritesUsecase.addFavoriteProducts(event.productIds);
    result.fold(
      (failure) => emit(AddFavoriteError(failure.toString())),
      (message) => emit(AddFavoriteSuccess(message)),
    );
    
    }
  }

