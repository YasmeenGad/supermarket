import 'package:dartz/dartz.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/checkout/data/datasource/payment_remote_datasource.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_model.dart';
import 'package:supermarket/features/checkout/domain/repositories/payment_repo.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final NetworkInfo networkInfo;
  final PaymentRemoteDatasource paymentRemoteDatasource;

  PaymentRepositoryImpl({
    required this.networkInfo,
    required this.paymentRemoteDatasource,
  });

  @override
  Future<Either<String, PaymentIntentModel>> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    if (!await networkInfo.isConnected) {
      return const Left('No internet connection');
    }
    try {
      final paymentIntentModel = await paymentRemoteDatasource
          .createPaymentIntent(paymentIntentInputModel);
      return Right(paymentIntentModel);
    } on Exception {
      return const Left('Failed to create payment intent');
    }
  }

  @override
  Future<Either<String, void>> initPaymentSheet(
      {required String paymentIntentClientSecret}) async {
    if (!await networkInfo.isConnected) {
      return const Left('No internet connection');
    }
    try {
      await paymentRemoteDatasource.initPaymentSheet(
          paymentIntentClientSecret: paymentIntentClientSecret);
      return const Right(null);
    } on Exception {
      return const Left('Failed to initialize payment sheet');
    }
  }

  @override
  Future<Either<String, void>> displayPaymentSheet() async {
    if (!await networkInfo.isConnected) {
      return const Left('No internet connection');
    }
    try {
      await paymentRemoteDatasource.displayPaymentSheet();
      return const Right(null);
    } on Exception {
      return const Left('Failed to display payment sheet');
    }
  }

  @override
  Future<Either<String, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await paymentRemoteDatasource.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return const Right(null);
    } catch (e) {
      return Left("failed to make payment");
    }
  }
}
