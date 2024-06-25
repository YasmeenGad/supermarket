import 'package:dartz/dartz.dart';
import 'package:supermarket/features/auth/domain/entities/user.dart';
import 'package:supermarket/features/auth/domain/repositories/auth_repositories.dart';

class RegisterUsecase{

  final AuthRepositories authRepositories;

  RegisterUsecase({required this.authRepositories});

  Future<Either<Exception,User>> call(String userName, String email, String password) async{  
    return await authRepositories.register(userName, email, password);
  }
}