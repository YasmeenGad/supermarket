import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:supermarket/features/favorite/domain/entities/delete_one_favorite_product.dart';
import 'package:supermarket/features/favorite/domain/usecases/favorite_usecase.dart';

part 'delete_one_favorite_product_event.dart';
part 'delete_one_favorite_product_state.dart';

class DeleteOneFavoriteProductBloc
    extends Bloc<DeleteOneFavoriteProductEvent, DeleteOneFavoriteProductState> {
  final AddFavoriteProductsUseCase deleteFavoriteProductsUseCase;
  DeleteOneFavoriteProductBloc(this.deleteFavoriteProductsUseCase)
      : super(DeleteOneFavoriteProductInitial()) {
    on<DeleteOneFavoriteProductItem>(_deleteOneFavoriteProduct);
  }

  Future<void> _deleteOneFavoriteProduct(DeleteOneFavoriteProductItem event,
      Emitter<DeleteOneFavoriteProductState> emit) async {
    emit(DeleteOneFavoriteProductLoading());
    final result =
        await deleteFavoriteProductsUseCase.deleteOneFavoriteProduct(event.id);
    result.fold(
      (l) => emit(DeleteOneFavoriteProductError(message: l.toString())),
      (r) => emit(DeleteOneFavoriteProductSuccess(deleteOneFavoriteProduct: r)),
    );
  }
}
