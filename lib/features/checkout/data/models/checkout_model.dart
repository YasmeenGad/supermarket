import 'package:supermarket/features/checkout/domain/entities/checkout.dart';

class CheckoutModel extends CheckoutEntity {
  CheckoutModel({
    required String id,
    required String address,
    required String payment,
  }) : super(id: id, address: address, payment: payment);

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
      id: json['_id'],
      address: json['address'],
      payment: json['payment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "address": address,
      "payment": payment,
    };
  }
}
