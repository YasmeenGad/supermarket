import 'package:equatable/equatable.dart';

class PaymentIntentInputModel extends Equatable {
  final dynamic amount;
  final String currency;
  const PaymentIntentInputModel({required this.amount, required this.currency});

  toJson() {
    return {'amount': "${amount}00", 'currency': currency};
  }

  @override
  List<Object?> get props => [amount, currency];
}
