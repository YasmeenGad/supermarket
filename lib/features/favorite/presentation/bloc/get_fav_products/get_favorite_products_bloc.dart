import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:supermarket/features/favorite/domain/entities/get_favorite.dart';
import 'package:supermarket/features/favorite/domain/usecases/favorite_usecase.dart';

part 'get_favorite_products_event.dart';
part 'get_favorite_products_state.dart';

class GetFavoriteProductsBloc
    extends Bloc<GetFavoriteProductsEvent, GetFavoriteProductsState> {
  final AddFavoriteProductsUseCase usecase;
  GetFavoriteProductsBloc(this.usecase) : super(GetFavoriteProductsInitial()) {
    on<GetFavoriteProducts>(_getFavoriteProducts);
  }

  Future<void> _getFavoriteProducts(
      GetFavoriteProducts event, Emitter<GetFavoriteProductsState> emit) async {
    emit(GetFavoriteProductsLoading());
    final result = await usecase.getFavoriteProducts(event.id);
    result.fold(
      (l) => emit(GetFavoriteProductsError(l)),
      (r) => emit(GetFavoriteProductsSuccess(r)),
    );
  }
}
