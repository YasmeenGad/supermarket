import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:supermarket/features/checkout/domain/usecase/payment_usecase.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentUsecase paymentUsecase;
  PaymentBloc({required this.paymentUsecase}) : super(PaymentInitial()) {
    on<MakePaymentEvent>(_makePayment);
  }

  Future<void> _makePayment(
    MakePaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    final result = await paymentUsecase.makePayment(
        paymentIntentInputModel: event.paymentIntentInputModel);

    result.fold(
      (failure) => emit(PaymentError(message: failure.toString())),
      (success) => emit(PaymentSuccess()),
    );
  }

  @override
  void onChange(Change<PaymentState> change) {
    super.onChange(change);
    log(change as num);
  }
}
