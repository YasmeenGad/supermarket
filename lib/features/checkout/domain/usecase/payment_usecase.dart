import 'package:dartz/dartz.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_model.dart';
import 'package:supermarket/features/checkout/domain/repositories/payment_repo.dart';

typedef PaymentIntentResult = Either<String, PaymentIntentModel>;
typedef InitPaymentSheetResult = Either<String, void>;

class PaymentUsecase {
  final PaymentRepository paymentRepository;

  PaymentUsecase({required this.paymentRepository});

  Future<PaymentIntentResult> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    return await paymentRepository.createPaymentIntent(paymentIntentInputModel);
  }

  Future<InitPaymentSheetResult> initPaymentSheet(
      {required String paymentIntentClientSecret}) async {
    return await paymentRepository.initPaymentSheet(
        paymentIntentClientSecret: paymentIntentClientSecret);
  }

  Future<InitPaymentSheetResult> displayPaymentSheet() async {
    return await paymentRepository.displayPaymentSheet();
  }

  Future<Either<String, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    return await paymentRepository.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
  }
}
