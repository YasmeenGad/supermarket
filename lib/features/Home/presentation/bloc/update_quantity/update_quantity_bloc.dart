import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:supermarket/features/Home/domain/entities/product.dart';
import 'package:supermarket/features/Home/domain/usecases/get_all_products_usecase.dart';

part 'update_quantity_event.dart';
part 'update_quantity_state.dart';

class UpdateQuantityBloc
    extends Bloc<UpdateQuantityEvent, UpdateQuantityState> {
  final GetProductsUseCase getProductsUseCase;
  UpdateQuantityBloc(this.getProductsUseCase) : super(UpdateQuantityInitial()) {
    on<UpdateQuantity>(_updateQuantity);
  }

  Future<void> _updateQuantity(
      UpdateQuantity event, Emitter<UpdateQuantityState> emit) async {
    emit(UpdateQuantityLoading());
    final products =
        await getProductsUseCase.updateQuantity(event.id, event.quantity);

    products.fold(
      (failure) => emit(UpdateQuantityError(failure.message.toString())),
      (products) => emit(UpdateQuantitySuccess(products)),
    );
  }
}
