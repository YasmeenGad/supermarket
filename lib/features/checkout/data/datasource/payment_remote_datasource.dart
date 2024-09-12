import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:supermarket/core/constants/api_keys.dart';
import 'package:supermarket/core/constants/ip.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/checkout/data/models/checkout_model.dart';
import 'package:supermarket/features/checkout/data/models/create_customer_model.dart';
import 'package:supermarket/features/checkout/data/models/ephemeral_key_model.dart';
import 'package:supermarket/features/checkout/data/models/init_payment_sheet_input_model.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_model.dart';
import 'package:http/http.dart' as http;
abstract class PaymentRemoteDatasource {
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel);

  Future initPaymentSheet(
      {required InitPaymentSheetInputModel initPaymentSheetInputModel});

  Future displayPaymentSheet();

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel});
  Future<CustomerModel> createCustomer(String name);

  Future<EphemeralKeyModel> createEphemeralKey(String customerId);

  Future<CheckoutModel> updateCheckout(String orderId, String paymentMethod);
}

class PaymentRemoteDatasourceImpl implements PaymentRemoteDatasource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;
  PaymentRemoteDatasourceImpl(
      {required this.authLocalDataSource, required this.client});

  @override
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    final data = paymentIntentInputModel.toJson();
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');

    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${ApiKeys.secretKey}',
    };

    final response = await client.post(
      url,
      body: data,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return PaymentIntentModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to create payment intent');
    }
  }

  @override
  Future initPaymentSheet(
      {required InitPaymentSheetInputModel initPaymentSheetInputModel}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret:
          initPaymentSheetInputModel.paymentIntentClientSecret,
      merchantDisplayName: 'Yasmeen',
      customerEphemeralKeySecret:
          initPaymentSheetInputModel.customerEphemeralKeySecret,
      customerId: initPaymentSheetInputModel.customerId,
    ));
  }

  @override
  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  @override
  Future<CustomerModel> createCustomer(String name) async {
    final body = {"name": name};

    final url = Uri.parse('https://api.stripe.com/v1/customers');

    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${ApiKeys.secretKey}',
    };

    final response = await client.post(
      url,
      body: body,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return CustomerModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to create Customer');
    }
  }

  @override
  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    var ephemeralKeyModel =
        await createEphemeralKey(paymentIntentInputModel.customerId);
    final InitPaymentSheetInputModel initPaymentSheetInputModel =
        InitPaymentSheetInputModel(
      paymentIntentClientSecret: paymentIntentModel.clientSecret,
      customerEphemeralKeySecret: ephemeralKeyModel.secret,
      customerId: paymentIntentInputModel.customerId,
    );
    await initPaymentSheet(
        initPaymentSheetInputModel: initPaymentSheetInputModel);
    await displayPaymentSheet();
  }

  @override
  Future<EphemeralKeyModel> createEphemeralKey(String customerId) async {
    final body = {
      "customer": customerId,
    };
    final url = Uri.parse('https://api.stripe.com/v1/ephemeral_keys');

    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${ApiKeys.secretKey}',
      'Stripe-Version': '2024-06-20',
    };
    final response = await client.post(
      url,
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return EphemeralKeyModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to create Ephemeral Key');
    }
  }

  @override
  Future<CheckoutModel> updateCheckout(
      String orderId, String paymentMethod) async {
    final token = await authLocalDataSource.getCachedLoginResponse();
    final accessToken = token?.token;
    final url = Uri.parse('http://$ip:4000/checkout/$orderId');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final body = {"payment": paymentMethod};
    final response = await client.patch(
      url,
      body: jsonEncode(body),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return CheckoutModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to update checkout');
    }
  }
}
