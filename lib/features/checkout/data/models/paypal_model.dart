import 'package:supermarket/features/checkout/domain/entities/paypal_entity.dart';

class PaypalModel extends PayPalEntity {
  PaypalModel({
    required String total,
    required String currency,
    required PaypalDetailsModel details,
  }) : super(
          total: total,
          currency: currency,
          details: details,
        );

  factory PaypalModel.fromJson(Map<String, dynamic> json) {
    return PaypalModel(
      total: json['total'],
      currency: json['currency'],
      details: PaypalDetailsModel.fromJson(json['details']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total.toString(),
      'currency': currency,
      'details': details,
    };
  }
}

class PaypalDetailsModel extends PaypalEntityDetails {
  PaypalDetailsModel({
    required String subtotal,
    required String shipping,
    required int shippingDiscount,
  }) : super(
          subtotal: subtotal,
          shipping: shipping,
          shippingDiscount: shippingDiscount,
        );

  factory PaypalDetailsModel.fromJson(Map<String, dynamic> json) {
    return PaypalDetailsModel(
      subtotal: json['subtotal'],
      shipping: json['shipping'],
      shippingDiscount: json['shipping_discount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subtotal': subtotal.toString(),
      'shipping': shipping.toString(),
      'shipping_discount': shippingDiscount,
    };
  }
}
