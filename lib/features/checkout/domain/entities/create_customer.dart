class Customer {
  final String id;
  final String object;
  final String? address;
  final int balance;
  final DateTime created;
  final String? currency;
  final String? defaultSource;
  final bool delinquent;
  final String? description;
  final String? discount;
  final String? email;
  final String invoicePrefix;
  final InvoiceSettings invoiceSettings;
  final bool livemode;
  final Map<String, dynamic> metadata;
  final String name;
  final int nextInvoiceSequence;
  final String? phone;
  final List<String> preferredLocales;
  final String? shipping;
  final String taxExempt;
  final String? testClock;

  Customer({
    required this.id,
    required this.object,
    this.address,
    required this.balance,
    required this.created,
    this.currency,
    this.defaultSource,
    required this.delinquent,
    this.description,
    this.discount,
    this.email,
    required this.invoicePrefix,
    required this.invoiceSettings,
    required this.livemode,
    required this.metadata,
    required this.name,
    required this.nextInvoiceSequence,
    this.phone,
    required this.preferredLocales,
    this.shipping,
    required this.taxExempt,
    this.testClock,
  });
}

class InvoiceSettings {
  final String? customFields;
  final String? defaultPaymentMethod;
  final String? footer;
  final String? renderingOptions;

  InvoiceSettings({
    this.customFields,
    this.defaultPaymentMethod,
    this.footer,
    this.renderingOptions,
  });
}
