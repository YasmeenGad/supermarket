import 'package:dartz/dartz.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:supermarket/features/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoriesImp implements AuthRepositories {
  final AuthLocalDataSource authLocalDataSource;
  final AuthRemoteDatasource authRemoteDatasource;
  final NetworkInfo networkInfo;

  AuthRepositoriesImp(
      {required this.authLocalDataSource,
      required this.authRemoteDatasource,
      required this.networkInfo});

  @override
  Future<Either<String, String>> login(String email, String password) async {
    if (!await networkInfo.isConnected) {
      return Left('No internet connection');
    } else {
      try {
        final remoteUser = await authRemoteDatasource.login(email, password);
        await authLocalDataSource.cacheToken(remoteUser.token ?? '');
        print(remoteUser.token);
        return Right('Login successful');
      } catch (e) {
        return Left('$e');
      }
    }
  }

  @override
  Future<Either<String, String>> register(
      String userName, String email, String password) async {
    if (!await networkInfo.isConnected) {
      return Left('No internet connection');
    } else {
      try {
        final newUser =
            await authRemoteDatasource.register(userName, email, password);
        await authLocalDataSource.cacheUser(newUser);
        return Right('Register successful');
      } catch (e) {
        return Left(e.toString());
      }
    }
  }

  @override
  Future<Either<String, String>> sendOtp(String email) async {
    if (await networkInfo.isConnected) {
      try {
        final message = await authRemoteDatasource.sendOtp(email);
        return Right(message);
      } catch (e) {
        return Left('Failed to Send Reset Code: $e');
      }
    } else {
      return Left('No Internet Connection');
    }
  }

  @override
  Future<Either<String, String>> verifyOtp(String otp) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await authRemoteDatasource.verifyOtp(otp);
        await authLocalDataSource.cacheToken(token); // Cache the token locally
        return Right(token);
      } catch (e) {
        return Left('$e');
      }
    } else {
      return Left('No Internet Connection');
    }
  }

  @override
  Future<Either<String, String>> resetPassword(
      String token, String newPassword) async {
    if (await networkInfo.isConnected) {
      try {
        final message =
            await authRemoteDatasource.resetPassword(token, newPassword);
        return Right(message);
      } catch (e) {
        return Left('Failed to Reset Password: $e');
      }
    } else {
      return Left('No Internet Connection');
    }
  }
}
