part of 'payment_bloc.dart';

@immutable
sealed class PaymentState extends Equatable{

  @override
  List<Object?> get props => [];
}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentSuccess extends PaymentState {}

final class PaymentError extends PaymentState {
  final String message;
  PaymentError({required this.message});

  @override
  List<Object?> get props => [message];

}
