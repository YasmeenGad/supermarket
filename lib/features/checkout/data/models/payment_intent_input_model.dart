import 'package:equatable/equatable.dart';

class PaymentIntentInputModel extends Equatable {
  final String amount;
  final String currency;
  const PaymentIntentInputModel({required this.amount, required this.currency});

  toJson() {
    return {'amount': amount, 'currency': currency};
  }

  @override
  List<Object?> get props => [amount, currency];
}
