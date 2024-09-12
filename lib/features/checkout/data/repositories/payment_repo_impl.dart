import 'package:dartz/dartz.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/checkout/data/datasource/payment_local_datasource.dart';
import 'package:supermarket/features/checkout/data/datasource/payment_remote_datasource.dart';
import 'package:supermarket/features/checkout/data/models/ephemeral_key_model.dart';
import 'package:supermarket/features/checkout/data/models/init_payment_sheet_input_model.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_model.dart';
import 'package:supermarket/features/checkout/domain/entities/checkout.dart';
import 'package:supermarket/features/checkout/domain/entities/create_customer.dart';
import 'package:supermarket/features/checkout/domain/repositories/payment_repo.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final NetworkInfo networkInfo;
  final PaymentRemoteDatasource paymentRemoteDatasource;
  final PaymentLocalDatasource paymentLocalDatasource;

  PaymentRepositoryImpl({
    required this.networkInfo,
    required this.paymentRemoteDatasource,
    required this.paymentLocalDatasource,
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
      {required InitPaymentSheetInputModel initPaymentSheetInputModel}) async {
    if (!await networkInfo.isConnected) {
      return const Left('No internet connection');
    }
    try {
      await paymentRemoteDatasource.initPaymentSheet(
          initPaymentSheetInputModel: initPaymentSheetInputModel);
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
    if (!await networkInfo.isConnected) {
      return const Left(
          'No internet connection, Please Connect to Internet and try again');
    }
    try {
      await paymentRemoteDatasource.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return const Right(null);
    } on Exception {
      return const Left('Payment Processing not completed');
    }
  }

  @override
  Future<Either<String, Customer>> createCustomer(String name) async {
    if (!await networkInfo.isConnected) {
      return const Left(
          'No internet connection, Please Connect to Internet and try again');
    }
    try {
      final customer = await paymentRemoteDatasource.createCustomer(name);
      await paymentLocalDatasource.cacheCustomer(customer);
      return Right(customer);
    } on Exception {
      return const Left('Failed to create customer');
    }
  }

  @override
  Future<Either<String, EphemeralKeyModel>> createEphemeralKey(
      String customerId) async {
    if (!await networkInfo.isConnected) {
      return const Left(
          'No internet connection, Please Connect to Internet and try again');
    }
    try {
      final ephemeralKey =
          await paymentRemoteDatasource.createEphemeralKey(customerId);
      return Right(ephemeralKey);
    } on Exception {
      return const Left('Failed to create ephemeral key');
    }
  }

  @override
  Future<Either<String, CheckoutEntity>> updateCheckout(String orderId, String paymentMethod)async {
    if (!await networkInfo.isConnected) {
      return const Left(
          'No internet connection, Please Connect to Internet and try again');
    }
    try {
      final checkout = await paymentRemoteDatasource.updateCheckout(orderId, paymentMethod);
      await paymentLocalDatasource.cacheCheckout(checkout);
      return Right(checkout);
    } on Exception {
      return const Left('Failed to update checkout');
    }
  }
}
