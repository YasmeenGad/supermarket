import 'package:dartz/dartz.dart';
import 'package:supermarket/core/error/failure.dart';
import 'package:supermarket/features/checkout/data/models/ephemeral_key_model.dart';
import 'package:supermarket/features/checkout/data/models/init_payment_sheet_input_model.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_model.dart';
import 'package:supermarket/features/checkout/domain/entities/checkout.dart';
import 'package:supermarket/features/checkout/domain/entities/create_customer.dart';

import '../../data/models/payment_intent_input_model.dart';

abstract class PaymentRepository {
  Future<Either<Failure, PaymentIntentModel>> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel);
  Future<Either<Failure, void>> initPaymentSheet(
      {required InitPaymentSheetInputModel initPaymentSheetInputModel});
  Future<Either<Failure, void>> displayPaymentSheet();
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel});
  Future<Either<Failure, Customer>> createCustomer(String name);
  Future<Either<Failure,EphemeralKeyModel>> createEphemeralKey(String customerId);
  Future<Either<Failure, CheckoutEntity>> updateCheckout(String orderId, String paymentMethod);
}
