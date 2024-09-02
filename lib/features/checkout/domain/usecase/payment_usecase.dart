import 'package:dartz/dartz.dart';
import 'package:supermarket/features/checkout/data/models/ephemeral_key_model.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_model.dart';
import 'package:supermarket/features/checkout/domain/entities/create_customer.dart';
import 'package:supermarket/features/checkout/domain/repositories/payment_repo.dart';

typedef PaymentIntentResult = Either<String, PaymentIntentModel>;
typedef InitPaymentSheetResult = Either<String, void>;
typedef MakePaymentResult = Either<String, void>;
typedef CreateCustomerResult= Either<String, Customer>;
typedef CreateEphemeralKeyResult= Either<String, EphemeralKeyModel>;
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

  Future<MakePaymentResult> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    return await paymentRepository.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
  }

   Future<CreateCustomerResult> createCustomer(
      String name) async {
    return await paymentRepository.createCustomer(name);
  }

  Future<CreateEphemeralKeyResult> createEphemeralKey(String customerId) async {
    return await paymentRepository.createEphemeralKey(customerId);
  }
}
