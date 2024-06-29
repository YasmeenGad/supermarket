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
        authLocalDataSource.cacheUser(remoteUser);
        await authLocalDataSource.cacheToken(remoteUser.token);
        print(remoteUser.token);
        return Right('Login successful');
      } catch (e) {
        return Left('$e');
      }
    }
  }

  @override
  Future<Either<String, String>> register(String userName, String email, String password) async {
    if (!await networkInfo.isConnected) {
      return Left('No internet connection');
    } else {
      try {
        final message = await authRemoteDatasource.register(userName, email, password);
        return Right(message);
      } catch (e) {
        return Left(e.toString());
      }
    }
  }
}
