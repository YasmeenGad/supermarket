import 'package:dartz/dartz.dart';
import 'package:supermarket/features/checkout/data/models/ephemeral_key_model.dart';
import 'package:supermarket/features/checkout/data/models/init_payment_sheet_input_model.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_model.dart';
import 'package:supermarket/features/checkout/domain/entities/create_customer.dart';

import '../../data/models/payment_intent_input_model.dart';

abstract class PaymentRepository {
  Future<Either<String, PaymentIntentModel>> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel);
  Future<Either<String, void>> initPaymentSheet(
      {required InitPaymentSheetInputModel initPaymentSheetInputModel});
  Future<Either<String, void>> displayPaymentSheet();
  Future<Either<String, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel});
  Future<Either<String, Customer>> createCustomer(String name);
  Future<Either<String,EphemeralKeyModel>> createEphemeralKey(String customerId);
}
