import 'package:dartz/dartz.dart';
import 'package:supermarket/features/auth/domain/repositories/auth_repositories.dart';

class LoginUsecase{
  final AuthRepositories authRepositories;
  LoginUsecase({required this.authRepositories});

  Future<Either<String, String>> call(String email, String password)async{
    return await authRepositories.login(email, password);
  }
}