import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:supermarket/core/constants/api_keys.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_model.dart';
import 'package:http/http.dart' as http;

abstract class PaymentRemoteDatasource {
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel);

  Future initPaymentSheet({required String paymentIntentClientSecret});

  Future displayPaymentSheet();

  Future makePayment({required PaymentIntentInputModel paymentIntentInputModel});
}

class PaymentRemoteDatasourceImpl implements PaymentRemoteDatasource {
  final http.Client client;
  PaymentRemoteDatasourceImpl({required this.client});

  @override
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    final body = paymentIntentInputModel.toJson();
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');

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
      return PaymentIntentModel.fromJson(response.body as Map<String, dynamic>);
    } else {
      throw Exception('Failed to create payment intent');
    }
  }

  @override
  Future initPaymentSheet(
      {required String paymentIntentClientSecret}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: paymentIntentClientSecret,
      merchantDisplayName: 'Yasmeen',
    ));
  }

  @override
  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }
  
  @override
  Future makePayment({required PaymentIntentInputModel paymentIntentInputModel}) async
  {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    await initPaymentSheet(paymentIntentClientSecret: paymentIntentModel.clientSecret);
    await displayPaymentSheet();
  }


}
