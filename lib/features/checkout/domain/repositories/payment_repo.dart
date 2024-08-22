import 'package:dartz/dartz.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_model.dart';

import '../../data/models/payment_intent_input_model.dart';

abstract class PaymentRepository {
  Future<Either<String, PaymentIntentModel>> createPaymentIntent(
      {required PaymentIntentInputModel paymentIntentInputModel});
}
