import 'package:dartz/dartz.dart';
import 'package:supermarket/features/auth/domain/entities/user.dart';

abstract class AuthRepositories {
  Future<Either<Exception,User>> login(String email, String password);
  Future<Either<Exception,User>> register(String userName, String email, String password);
}
