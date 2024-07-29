import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/features/cart/domain/entities/create_order_entity.dart';
import 'package:supermarket/features/cart/domain/usecases/order_usecase.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  final CreateOrderUsecase createOrderUsecase;
  CreateOrderBloc({required this.createOrderUsecase}) : super(CreateOrderInitial()) {
    on<CreateOrder>(_onCreateOrder);
  }

  Future<void> _onCreateOrder(CreateOrder event, Emitter<CreateOrderState> emit) async {
    emit(CreateOrderLoading());
    final result = await createOrderUsecase(event.productIds);
    result.fold(
      (l) => emit(CreateOrderError(l.toString())),
      (r) => emit(CreateOrderSuccess(r)),
    );
  }
}
