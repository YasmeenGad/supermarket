import 'package:equatable/equatable.dart';

class PaymentIntentInputModel extends Equatable {
  final dynamic amount;
  final String currency;
  final String customerId;
  const PaymentIntentInputModel({ required this.customerId ,required this.amount, required this.currency});

  toJson() {
    return {'amount': "${amount}00", 'currency': currency, 'customer': customerId};
  }

  @override
  List<Object?> get props => [amount, currency];
}
