class PaymentIntent {
  final String id;
  final String object;
  final int amount;
  final int amountCapturable;
  final AmountDetails amountDetails;
  final int amountReceived;
  final bool automaticPaymentMethodsEnabled;
  final String captureMethod;
  final String clientSecret;
  final String confirmationMethod;
  final int created;
  final String currency;
  final bool livemode;
  final PaymentMethodOptions paymentMethodOptions;
  final List<String> paymentMethodTypes;
  final String status;

  PaymentIntent({
    required this.id,
    required this.object,
    required this.amount,
    required this.amountCapturable,
    required this.amountDetails,
    required this.amountReceived,
    required this.automaticPaymentMethodsEnabled,
    required this.captureMethod,
    required this.clientSecret,
    required this.confirmationMethod,
    required this.created,
    required this.currency,
    required this.livemode,
    required this.paymentMethodOptions,
    required this.paymentMethodTypes,
    required this.status,
  });
}

class AmountDetails {
  final Map<String, dynamic> tip;

  AmountDetails({
    required this.tip,
  });
}

class PaymentMethodOptions {
  final CardOptions card;
  final LinkOptions link;

  PaymentMethodOptions({
    required this.card,
    required this.link,
  });
}

class CardOptions {
  final String requestThreeDSecure;

  CardOptions({
    required this.requestThreeDSecure,
  });
}

class LinkOptions {
  final String? persistentToken;

  LinkOptions({
    this.persistentToken,
  });
}
