part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MakePaymentEvent extends PaymentEvent {
  final PaymentIntentInputModel paymentIntentInputModel;
  MakePaymentEvent({required this.paymentIntentInputModel});

  @override
  List<Object?> get props => [paymentIntentInputModel];
}
