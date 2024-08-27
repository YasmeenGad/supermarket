import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/features/cart/domain/entities/fetch_order_entities.dart';
import 'package:supermarket/features/cart/domain/usecases/order_usecase.dart';

part 'get_order_event.dart';
part 'get_order_state.dart';

class GetOrderBloc extends Bloc<GetOrderEvent, GetOrderState> {
  final OrderUsecases getOrderUseCase;
  GetOrderBloc({required this.getOrderUseCase}) : super(GetOrderInitial()) {
    on<GetOrder>(_getOrderEvent);
  }

  Future<void> _getOrderEvent(
      GetOrder event, Emitter<GetOrderState> emit) async {
    emit(GetOrderLoading());
    final result = await getOrderUseCase.getOrder();
    result.fold(
      (l) => emit(GetOrderError(l.message)),
      (r) => emit(GetOrderSuccess(r)),
    );
  }
}
