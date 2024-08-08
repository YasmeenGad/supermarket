import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/features/favorite/domain/entities/fav_products.dart';
import 'package:supermarket/features/favorite/domain/usecases/favorites_usecase.dart';

part 'get_favorite_event.dart';
part 'get_favorite_state.dart';

class GetFavoriteBloc extends Bloc<GetFavoriteEvent, GetFavoriteState> {
 final FavoritesUsecase favoritesUsecase;
  GetFavoriteBloc(this.favoritesUsecase) : super(GetFavoriteInitial()) {
    on<GetFavoriteProducts>(_getFavoriteProducts);
  }

  Future<void> _getFavoriteProducts(
      GetFavoriteProducts event, Emitter<GetFavoriteState> emit) async {
    emit(GetFavoriteLoading());
    final result = await favoritesUsecase.getFavoriteProducts(event.id);
    result.fold(
      (failure) => emit(GetFavoriteError(failure.toString())),
      (products) => emit(GetFavoriteSuccess(products)),
    );
  }
}
