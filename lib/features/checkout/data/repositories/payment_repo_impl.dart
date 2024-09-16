import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:supermarket/core/error/exceptions.dart';
import 'package:supermarket/core/error/failure.dart';
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
  Future<Either<Failure, PaymentIntentModel>> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final paymentIntentModel = await paymentRemoteDatasource
          .createPaymentIntent(paymentIntentInputModel);
      return Right(paymentIntentModel);
    } on ServerException catch (e) {
      if (e.statusCode >= 500) {
        return const Left(InternalServerErrorFailure());
      }
      return Left(ServerFailure(e.message, e.statusCode));
    } on TimeoutException {
      return const Left(TimeoutFailure());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> initPaymentSheet(
      {required InitPaymentSheetInputModel initPaymentSheetInputModel}) async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      await paymentRemoteDatasource.initPaymentSheet(
          initPaymentSheetInputModel: initPaymentSheetInputModel);
      return const Right(null);
    } on ServerException catch (e) {
      if (e.statusCode >= 500) {
        return const Left(InternalServerErrorFailure());
      }
      return Left(ServerFailure(e.message, e.statusCode));
    } on TimeoutException {
      return const Left(TimeoutFailure());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> displayPaymentSheet() async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      await paymentRemoteDatasource.displayPaymentSheet();
      return const Right(null);
    } on ServerException catch (e) {
      if (e.statusCode >= 500) {
        return const Left(InternalServerErrorFailure());
      }
      return Left(ServerFailure(e.message, e.statusCode));
    } on TimeoutException {
      return const Left(TimeoutFailure());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      await paymentRemoteDatasource.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return const Right(null);
    } on ServerException catch (e) {
      if (e.statusCode >= 500) {
        return const Left(InternalServerErrorFailure());
      }
      return Left(ServerFailure(e.message, e.statusCode));
    } on TimeoutException {
      return const Left(TimeoutFailure());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Customer>> createCustomer(String name) async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final customer = await paymentRemoteDatasource.createCustomer(name);
      await paymentLocalDatasource.cacheCustomer(customer);
      return Right(customer);
    } on ServerException catch (e) {
      if (e.statusCode >= 500) {
        return const Left(InternalServerErrorFailure());
      }
      return Left(ServerFailure(e.message, e.statusCode));
    } on TimeoutException {
      return const Left(TimeoutFailure());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EphemeralKeyModel>> createEphemeralKey(
      String customerId) async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final ephemeralKey =
          await paymentRemoteDatasource.createEphemeralKey(customerId);
      return Right(ephemeralKey);
    } on ServerException catch (e) {
      if (e.statusCode >= 500) {
        return const Left(InternalServerErrorFailure());
      }
      return Left(ServerFailure(e.message, e.statusCode));
    } on TimeoutException {
      return const Left(TimeoutFailure());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CheckoutEntity>> updateCheckout(
      String orderId, String paymentMethod) async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final checkout =
          await paymentRemoteDatasource.updateCheckout(orderId, paymentMethod);
      await paymentLocalDatasource.cacheCheckout(checkout);
      return Right(checkout);
    } on ServerException catch (e) {
      if (e.statusCode >= 500) {
        return const Left(InternalServerErrorFailure());
      }
      return Left(ServerFailure(e.message, e.statusCode));
    } on TimeoutException {
      return const Left(TimeoutFailure());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
