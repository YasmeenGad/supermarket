import 'package:dartz/dartz.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_model.dart';
import 'package:supermarket/features/checkout/domain/repositories/payment_repo.dart';

class PaymentUsecase {
  final PaymentRepository paymentRepository;

  PaymentUsecase({required this.paymentRepository});

  Future<Either<String, PaymentIntentModel>> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    return await paymentRepository.createPaymentIntent(paymentIntentInputModel);
  }
}
