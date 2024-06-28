import 'package:dartz/dartz.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/auth/data/datasources/auth_remote_datasources.dart';

import 'package:supermarket/features/auth/domain/entities/user.dart';

import 'package:supermarket/features/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoriesImp implements AuthRepositories {
  final AuthLocalDataSource authLocalDataSource;
  final AuthRemoteDatasource authRemoteDatasource;
  final NetworkInfo networkInfo;

  AuthRepositoriesImp({required this.authLocalDataSource,
      required this.authRemoteDatasource, required this.networkInfo});

  @override
  Future<Either<String, User>> login(String email, String password) async {
    if (!await networkInfo.isConnected) {
      return Left('No internet connection');
    }

    try {
      final remoteUser = await authRemoteDatasource.login(email, password);
      authLocalDataSource.cacheUser(remoteUser);
      return Right(remoteUser);
    } catch (e) {
      return Left('failed to login: $e');
    }
  }

  @override
  Future<Either<String, User>> register(
      String username, String email, String password) async {
    if (!await networkInfo.isConnected) {
      return Left('No internet connection');
    }

    try {
      final remoteUser =
          await authRemoteDatasource.register(username, email, password);
      authLocalDataSource.cacheUser(remoteUser);
      return Right(remoteUser);
    } catch (e) {
      return Left('Faild to register: $e');
    }
  }
}
