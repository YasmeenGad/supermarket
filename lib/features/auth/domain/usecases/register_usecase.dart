import 'package:dartz/dartz.dart';
import '../repositories/auth_repositories.dart';

class RegisterUsecase {
  final AuthRepositories repository;

  RegisterUsecase({ required this.repository});

  Future<Either<String, String>> call(String userName, String email, String password) {
    return repository.register(userName, email, password);
  }
}
