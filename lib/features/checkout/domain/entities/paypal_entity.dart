class PayPalEntity {
  final String total;
  final String currency;
  final PaypalEntityDetails details;

  PayPalEntity({
    required this.total,
    required this.currency,
    required this.details,
  });
}

class PaypalEntityDetails {
  final String subtotal;
  final String shipping;
  final int shippingDiscount;

  PaypalEntityDetails({
    required this.subtotal,
    required this.shipping,
    required this.shippingDiscount,
  });
}
