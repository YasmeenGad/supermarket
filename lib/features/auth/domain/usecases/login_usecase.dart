import 'package:dartz/dartz.dart';
import 'package:supermarket/features/auth/domain/entities/user.dart';
import 'package:supermarket/features/auth/domain/repositories/auth_repositories.dart';

class LoginUsecase{
  final AuthRepositories authRepositories;
  LoginUsecase({required this.authRepositories});

  Future<Either<Exception,User>> call(String email, String password){
    return authRepositories.login(email, password);
  }
}