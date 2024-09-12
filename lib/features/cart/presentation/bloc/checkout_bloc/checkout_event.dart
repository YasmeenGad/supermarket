part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class Checkout extends CheckoutEvent {
  final String orderId;
  final String paymentMethod;

  Checkout({required this.orderId, required this.paymentMethod});

  @override
  List<Object?> get props => [orderId, paymentMethod];
}
