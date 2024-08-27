import 'package:supermarket/features/checkout/domain/entities/create_customer.dart';

class CustomerModel extends Customer {
  CustomerModel({
    required String id,
    required String object,
    String? address,
    required int balance,
    required DateTime created,
    String? currency,
    String? defaultSource,
    required bool delinquent,
    String? description,
    String? discount,
    String? email,
    required String invoicePrefix,
    required InvoiceSettingsModel invoiceSettings,
    required bool livemode,
    required Map<String, dynamic> metadata,
    required String name,
    required int nextInvoiceSequence,
    String? phone,
    required List<String> preferredLocales,
    String? shipping,
    required String taxExempt,
    String? testClock,
  }) : super(
          id: id,
          object: object,
          address: address,
          balance: balance,
          created: created,
          currency: currency,
          defaultSource: defaultSource,
          delinquent: delinquent,
          description: description,
          discount: discount,
          email: email,
          invoicePrefix: invoicePrefix,
          invoiceSettings: invoiceSettings,
          livemode: livemode,
          metadata: metadata,
          name: name,
          nextInvoiceSequence: nextInvoiceSequence,
          phone: phone,
          preferredLocales: preferredLocales,
          shipping: shipping,
          taxExempt: taxExempt,
          testClock: testClock,
        );

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      object: json['object'],
      address: json['address'],
      balance: json['balance'],
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      currency: json['currency'],
      defaultSource: json['default_source'],
      delinquent: json['delinquent'],
      description: json['description'],
      discount: json['discount'],
      email: json['email'],
      invoicePrefix: json['invoice_prefix'],
      invoiceSettings: InvoiceSettingsModel.fromJson(json['invoice_settings']),
      livemode: json['livemode'],
      metadata: Map<String, dynamic>.from(json['metadata']),
      name: json['name'],
      nextInvoiceSequence: json['next_invoice_sequence'],
      phone: json['phone'],
      preferredLocales: List<String>.from(json['preferred_locales']),
      shipping: json['shipping'],
      taxExempt: json['tax_exempt'],
      testClock: json['test_clock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'object': object,
      'address': address,
      'balance': balance,
      'created': created.millisecondsSinceEpoch ~/ 1000,
      'currency': currency,
      'default_source': defaultSource,
      'delinquent': delinquent,
      'description': description,
      'discount': discount,
      'email': email,
      'invoice_prefix': invoicePrefix,
      'invoice_settings': (invoiceSettings as InvoiceSettingsModel).toJson(),
      'livemode': livemode,
      'metadata': metadata,
      'name': name,
      'next_invoice_sequence': nextInvoiceSequence,
      'phone': phone,
      'preferred_locales': preferredLocales,
      'shipping': shipping,
      'tax_exempt': taxExempt,
      'test_clock': testClock,
    };
  }
}

class InvoiceSettingsModel extends InvoiceSettings {
  InvoiceSettingsModel({
    String? customFields,
    String? defaultPaymentMethod,
    String? footer,
    String? renderingOptions,
  }) : super(
          customFields: customFields,
          defaultPaymentMethod: defaultPaymentMethod,
          footer: footer,
          renderingOptions: renderingOptions,
        );

  factory InvoiceSettingsModel.fromJson(Map<String, dynamic> json) {
    return InvoiceSettingsModel(
      customFields: json['custom_fields'],
      defaultPaymentMethod: json['default_payment_method'],
      footer: json['footer'],
      renderingOptions: json['rendering_options'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'custom_fields': customFields,
      'default_payment_method': defaultPaymentMethod,
      'footer': footer,
      'rendering_options': renderingOptions,
    };
  }
}
