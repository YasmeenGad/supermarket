import 'package:supermarket/features/checkout/domain/entities/payment_intent.dart';

class PaymentIntentModel extends PaymentIntent {
  PaymentIntentModel({
    required String id,
    required String object,
    required int amount,
    required int amountCapturable,
    required AmountDetailsModel amountDetails,
    required int amountReceived,
    required bool automaticPaymentMethodsEnabled,
    required String captureMethod,
    required String clientSecret,
    required String confirmationMethod,
    required int created,
    required String currency,
    required bool livemode,
    required PaymentMethodOptionsModel paymentMethodOptions,
    required List<String> paymentMethodTypes,
    required String status,
  }) : super(
          id: id,
          object: object,
          amount: amount,
          amountCapturable: amountCapturable,
          amountDetails: amountDetails,
          amountReceived: amountReceived,
          automaticPaymentMethodsEnabled: automaticPaymentMethodsEnabled,
          captureMethod: captureMethod,
          clientSecret: clientSecret,
          confirmationMethod: confirmationMethod,
          created: created,
          currency: currency,
          livemode: livemode,
          paymentMethodOptions: paymentMethodOptions,
          paymentMethodTypes: paymentMethodTypes,
          status: status,
        );

  factory PaymentIntentModel.fromJson(Map<String, dynamic> json) {
    return PaymentIntentModel(
      id: json['id'] as String,
      object: json['object'] as String,
      amount: json['amount'] as int,
      amountCapturable: json['amount_capturable'] as int,
      amountDetails: AmountDetailsModel.fromJson(json['amount_details'] ?? {}),
      amountReceived: json['amount_received'] as int? ?? 0,
      automaticPaymentMethodsEnabled: json['automatic_payment_methods']?['enabled'] as bool? ?? false,
      captureMethod: json['capture_method'] as String? ?? 'automatic',
      clientSecret: json['client_secret'] as String? ?? '',
      confirmationMethod: json['confirmation_method'] as String? ?? 'automatic',
      created: json['created'] as int? ?? 0,
      currency: json['currency'] as String? ?? 'usd',
      livemode: json['livemode'] as bool? ?? false,
      paymentMethodOptions: PaymentMethodOptionsModel.fromJson(json['payment_method_options'] ?? {}),
      paymentMethodTypes: List<String>.from(json['payment_method_types'] ?? []),
      status: json['status'] as String? ?? 'requires_payment_method',
    );
  }
}

class AmountDetailsModel extends AmountDetails {
  AmountDetailsModel({
    required Map<String, dynamic> tip,
  }) : super(tip: tip);

  factory AmountDetailsModel.fromJson(Map<String, dynamic> json) {
    return AmountDetailsModel(
      tip: json['tip'] ?? {},
    );
  }
}

class PaymentMethodOptionsModel extends PaymentMethodOptions {
  PaymentMethodOptionsModel({
    required CardOptionsModel card,
    required LinkOptionsModel link,
  }) : super(
          card: card,
          link: link,
        );

  factory PaymentMethodOptionsModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodOptionsModel(
      card: CardOptionsModel.fromJson(json['card'] ?? {}),
      link: LinkOptionsModel.fromJson(json['link'] ?? {}),
    );
  }
}

class CardOptionsModel extends CardOptions {
  CardOptionsModel({
    required String requestThreeDSecure,
  }) : super(requestThreeDSecure: requestThreeDSecure);

  factory CardOptionsModel.fromJson(Map<String, dynamic> json) {
    return CardOptionsModel(
      requestThreeDSecure: json['request_three_d_secure'] as String? ?? 'automatic',
    );
  }
}

class LinkOptionsModel extends LinkOptions {
  LinkOptionsModel({
    String? persistentToken,
  }) : super(persistentToken: persistentToken);

  factory LinkOptionsModel.fromJson(Map<String, dynamic> json) {
    return LinkOptionsModel(
      persistentToken: json['persistent_token'] as String?,
    );
  }
}
