part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  final CheckoutEntity checkout;
  CheckoutLoaded({required this.checkout});

  @override
  List<Object?> get props => [checkout];
}

class CheckoutError extends CheckoutState {
  final String message;
  CheckoutError({required this.message});

  @override
  List<Object?> get props => [message];
}
