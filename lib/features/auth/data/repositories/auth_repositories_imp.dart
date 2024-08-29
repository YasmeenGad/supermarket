import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:supermarket/core/error/exceptions.dart';
import 'package:supermarket/core/error/failure.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:supermarket/features/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoriesImp implements AuthRepositories {
  final AuthLocalDataSource authLocalDataSource;
  final AuthRemoteDatasource authRemoteDatasource;
  final NetworkInfo networkInfo;

  AuthRepositoriesImp({
    required this.authLocalDataSource,
    required this.authRemoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }

    try {
      final remoteUser = await authRemoteDatasource.login(email, password);
      await authLocalDataSource.cacheLoginResponse(remoteUser);
      return const Right('Login successful');
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
  Future<Either<Failure, String>> register(
      String userName, String email, String password) async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      // ignore: unused_local_variable
      final newUser =
          await authRemoteDatasource.register(userName, email, password);
      return const Right('Register successful');
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
  Future<Either<Failure, String>> sendOtp(String email) async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final message = await authRemoteDatasource.sendOtp(email);
      return Right(message);
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
  Future<Either<Failure, String>> verifyOtp(String otp) async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final token = await authRemoteDatasource.verifyOtp(otp);
      await authLocalDataSource.cacheToken(token);
      return Right(token);
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
  Future<Either<Failure, String>> resetPassword(
      String token, String newPassword) async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final message =
          await authRemoteDatasource.resetPassword(token, newPassword);
      return Right(message);
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
