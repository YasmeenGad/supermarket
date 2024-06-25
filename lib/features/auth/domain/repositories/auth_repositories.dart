import 'package:dartz/dartz.dart';
import 'package:supermarket/features/auth/domain/entities/user.dart';

abstract class AuthRepositories {
  Future<Either<String,User>> login(String email, String password);
  Future<Either<String,User>> register(String userName, String email, String password);
}
