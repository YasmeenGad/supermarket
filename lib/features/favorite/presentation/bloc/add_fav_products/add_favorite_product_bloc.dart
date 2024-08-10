import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:supermarket/features/favorite/domain/entities/add_favorite.dart';
import 'package:supermarket/features/favorite/domain/usecases/favorite_usecase.dart';

part 'add_favorite_product_event.dart';
part 'add_favorite_product_state.dart';

class AddFavoriteProductBloc
    extends Bloc<AddFavoriteProductEvent, AddFavoriteProductState> {
  final AddFavoriteProductsUseCase addFavoriteProductsUseCase;
  AddFavoriteProductBloc(this.addFavoriteProductsUseCase)
      : super(AddFavoriteProductInitial()) {
    on<AddFavoriteProduct>(_addFavoriteProduct);
  }

  Future<void> _addFavoriteProduct(
      AddFavoriteProduct event, Emitter<AddFavoriteProductState> emit) async {
    emit(AddFavoriteProductLoading());
    final isAdded = await addFavoriteProductsUseCase.addFavoriteProducts(event.productIds);

    isAdded.fold((l) => emit(AddFavoriteProductFailure(message: l.toString())),
        (r) => emit(AddFavoriteProductSuccess(addFavorite: r)));
  }
}
