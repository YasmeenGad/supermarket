import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:supermarket/features/checkout/domain/entities/checkout.dart';
import 'package:supermarket/features/checkout/domain/usecase/payment_usecase.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final PaymentUsecase checkout;
  CheckoutBloc({required this.checkout}) : super(CheckoutInitial()) {
    on<Checkout>(_checkoutEvent);
  }

  Future<void> _checkoutEvent(
      Checkout event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    final result =
        await checkout.updateCheckout(event.orderId, event.paymentMethod);
    result.fold((failure) => emit(CheckoutError(message: failure.toString())),
        (success) => emit(CheckoutLoaded(checkout: success)));
  }
}
